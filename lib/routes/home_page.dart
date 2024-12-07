import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/routes/components/side_menu.dart';
import 'package:employ_service/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String empname = '';
  String empdesig = '';
  String username = '';
  String company = '';
  String empposition = '';
  String empdepartment = '';
  String email = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    getPrefrenceName();
  }

  // get Prefrence Name
  Future<void> getPrefrenceName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      empname = prefs.getString('empname') ?? '';
      empdesig = prefs.getString('empdesig') ?? '';
      username = prefs.getString('username') ?? '';
      company = prefs.getString('company') ?? '';
      empposition = prefs.getString('empposition') ?? '';
      empdepartment = prefs.getString('empdepartment') ?? '';
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      title: 'Employee Service',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: const SideMenu(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/logo.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                        Container(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(height: 5),
                              AutoSizeText(empname,
                                  style: TextStyle(fontSize: 18)),
                              AutoSizeText(empdesig,
                                  style: TextStyle(fontSize: 15)),
                              Container(height: 5),
                              Row(children: <Widget>[
                                Icon(Icons.corporate_fare_outlined),
                                AutoSizeText(company,
                                    style: TextStyle(fontSize: 15)),
                              ]),
                              Container(height: 5),
                              Row(children: <Widget>[
                                Icon(Icons.email_outlined),
                                AutoSizeText(email,
                                    style: TextStyle(fontSize: 15)),
                              ]),
                              Container(height: 5),
                              Row(children: <Widget>[
                                Icon(Icons.phone_android_outlined),
                                AutoSizeText(phone,
                                    style: TextStyle(fontSize: 15)),
                              ]),
                              Container(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/routes/components/side_menu.dart';
import 'package:employ_service/theme/app_theme.dart';
import 'package:employ_service/routes/components/custom_sliver_app_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
        appBar: null,
        drawer: SideMenu(),
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                      mainAxisSize: MainAxisSize.min, // Shrinks to fit content
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: AutoSizeText(empname),
                          subtitle: AutoSizeText(empdesig),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

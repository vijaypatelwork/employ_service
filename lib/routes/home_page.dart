import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/routes/components/side_menu.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String empname = '';
  String empdesig = '';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Employee Service',
      home: Scaffold(
        appBar: AppBar(
          title: AutoSizeText('Employee Service'),
        ),
        drawer: const SideMenu(),
        body: Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            title: AutoSizeText(empname),
            subtitle: AutoSizeText(empdesig),
          ),
        ),
      ),
    );
  }
}

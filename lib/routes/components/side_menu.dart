import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/routes/home_page.dart';
import 'package:employ_service/routes/login_page.dart';
import 'package:employ_service/routes/quarter_service_complaint_list_page.dart';
import 'package:employ_service/routes/quarter_service_complaint_form_page.dart';

// Logout function
Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clear all the stored data
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: AutoSizeText('Hi, Employee'),
          ),
          ListTile(
            title: const AutoSizeText('Home'),
            leading: Icon(Icons.home_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ExpansionTile(
            title: const AutoSizeText('Quarter Service'),
            leading: Icon(Icons.build_outlined),
            children: <Widget>[
              ListTile(
                title: const AutoSizeText('Service Complains'),
                leading: Icon(Icons.build_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuarterServiceComplaintList()),
                  );
                },
              ),
              ListTile(
                title: const AutoSizeText('Book Service Complains'),
                leading: Icon(Icons.build_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuarterServiceComplaintForm()),
                  );
                },
              ),
            ],
          ),
          ListTile(
            title: const AutoSizeText('Logout'),
            leading: Icon(Icons.logout_outlined),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employ_service/routes/home_page.dart';
import 'package:employ_service/routes/login_page.dart';
import 'package:employ_service/routes/quarter_service_page.dart';
import 'package:employ_service/routes/quarter_service_complaint_page.dart';

// Logout function
Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clear all the stored data
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
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
            child: Text('Hi, Employee'),
          ),
          ListTile(
            title: const Text('Home'),
            leading: Icon(Icons.home_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ExpansionTile(
            title: const Text('Quarter Service'),
            leading: Icon(Icons.build_outlined),
            children: <Widget>[
              ListTile(
                title: const Text('Service Complains'),
                leading: Icon(Icons.build_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuarterServicePage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Book Service Complains'),
                leading: Icon(Icons.build_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const QuarterServiceComplaintPage()),
                  );
                },
              ),
            ],
          ),
          ListTile(
            title: const Text('Logout'),
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

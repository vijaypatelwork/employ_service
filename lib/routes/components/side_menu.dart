import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/routes/home_page.dart';
import 'package:employ_service/routes/login_page.dart';
import 'package:employ_service/routes/quarter_service_complaint_list_page.dart';
import 'package:employ_service/routes/profile_page.dart';
import 'package:employ_service/routes/components/circular.dart';

class SideMenu extends StatefulWidget {
  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFE4DAF4), // Background color
            ),
            child: Column(
              children: [
                Text(
                  "EMPLOYEE E-SUVIDHA",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  empname.toString(),
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  empdesig.toString(),
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  empdepartment.split(":")[2],
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  company.toString().toUpperCase(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          ListTile(
            title: AutoSizeText('Home'),
            leading: Icon(Icons.home_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: const AutoSizeText('E-Arogyam'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {},
          ),
          ExpansionTile(
            title: const AutoSizeText('Colony'),
            leading: Icon(Icons.build_outlined),
            children: <Widget>[
              ListTile(
                title: const AutoSizeText('Complains'),
                leading: Icon(Icons.build_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuarterServiceComplaintList()),
                  );
                },
              ),
            ],
          ),
          ListTile(
            title: const AutoSizeText('Employee Self-Service'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Circular()),
              );
            },
          ),
          ListTile(
            title: const AutoSizeText('Training'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const AutoSizeText('Education Policy'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const AutoSizeText('Sports'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const AutoSizeText('Canteen'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const AutoSizeText('Communication Hub'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const AutoSizeText('Profile'),
            leading: Icon(Icons.person_2_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            title: const AutoSizeText('Logout'),
            leading: Icon(Icons.logout_outlined),
            onTap: () {
              logout(context);
            },
          ),

          // Bottom Section: Footer
          Divider(),
          Container(
            child: Column(
              children: [
                // Row for Logo Image
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon.png',
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
                // Row for Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("© 2024 GUVNL"),
                  ],
                ),
              ],
            ),
          ),
          // Bottom Section: Footer
        ],
      ),
    );
  }
}

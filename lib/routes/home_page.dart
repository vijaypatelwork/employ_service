import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employ_service/routes/components/side_menu.dart';

// get Prefrence Name
Future<String> getPrefrenceName(String prefrenceName) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String prefrenceValue = prefs.getString(prefrenceName) ?? '';
  return prefrenceValue;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Employee Service',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Employee Service'),
        ),
        drawer: const SideMenu(),
        body: Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("images/bg.jpg"), fit: BoxFit.fill)),
          ),
          SingleChildScrollView(
              child: new Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            color: Colors.white.withOpacity(0.9),
          )),
          Column(children: <Widget>[
            /*Row(
            children: [
              FutureBuilder(
                future: getPrefrenceName('imageData'),
                builder: (context, snapshot) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.memory(
                      base64Decode('${snapshot.data}'),
                      height: 150.0,
                      width: 100.0,
                    ),
                  );
                },
              ),
            ],
          ),*/
            Row(
              children: [
                Text('Employee Name : '),
                FutureBuilder(
                  future: getPrefrenceName('empname'),
                  builder: (context, snapshot) {
                    return Text('${snapshot.data}');
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Employee Designation : '),
                FutureBuilder(
                  future: getPrefrenceName('empdesig'),
                  builder: (context, snapshot) {
                    return Text('${snapshot.data}');
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Employee Department : '),
                FutureBuilder(
                  future: getPrefrenceName('empdepartment'),
                  builder: (context, snapshot) {
                    return Text('${snapshot.data}');
                  },
                ),
              ],
            ),
          ]),
        ]),
      ),
    );
  }
}

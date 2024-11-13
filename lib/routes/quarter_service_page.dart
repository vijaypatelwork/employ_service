import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:employ_service/api/api_list.dart';
import 'package:employ_service/routes/components/side_menu.dart';

// get employee details
Future<List<dynamic>> getEmployeeComplainDetails() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';
  String company = prefs.getString('company') ?? '';
  var res = await http.post(Uri.parse(API.empdetails), body: {
    'empno': username,
    'company': company,
  });
  final json = "[" + res.body + "]";
  List EmployeeDetails = (jsonDecode(json) as List<dynamic>);
  return EmployeeDetails;
}

class QuarterServicePage extends StatelessWidget {
  const QuarterServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Quarter Service',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quarter Service'),
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
          FutureBuilder<List<dynamic>>(
            future: getEmployeeComplainDetails(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty) {
                return AnimatedList(
                  initialItemCount: snapshot.data!.length,
                  itemBuilder:
                      (BuildContext context, int index, Animation animation) {
                    return new Text(snapshot.data![index]['empname']);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ]),
      ),
    );
  }
}

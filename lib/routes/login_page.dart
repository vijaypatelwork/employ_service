import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/api/api_list.dart';
import 'package:employ_service/routes/home_page.dart';
import 'package:employ_service/theme/app_theme.dart';
import 'package:employ_service/routes/components/custom_sliver_app_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  String? selectedValue = '';
  List<String> companyList = [
    "GUVNL",
    "DGVCL",
    "MGVCL",
    "PGVCL",
    "UGVCL",
    "GSECL",
    "GETCO"
  ];
  LoginPageState() {
    selectedValue = companyList[0];
  }

  // Save login status
  Future<void> saveLoginDetails(
      bool isLoggedIn, String username, String company) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('username', username);
    await prefs.setString('company', company);
    var res = await http.post(Uri.parse(API.empdetails), body: {
      'empno': username,
      'company': company,
    });
    var result = json.decode(res.body);
    //Save Employee Details to Prefrence
    await prefs.setString('empname', result['empname']);
    await prefs.setString('empdesig', result['empdesig']);
    await prefs.setString('empposition', result['empposition']);
    await prefs.setString('empdepartment', result['empdepartment']);
    await prefs.setString('email', result['email']);
    await prefs.setString('phone', result['phone']);
    await prefs.setString('imageData', result['imageData']);
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
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 30),
                          const AutoSizeText(
                            "Welcome Employee",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText(
                              "Please login with your E-Urja Username and Password"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: username_controller,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Employee ID';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Username | Employee ID",
                                prefixIcon: const Icon(Icons.person)),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: password_controller,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.password),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),
                          DropdownButtonFormField<String>(
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Company';
                              }
                              return null;
                            },
                            items: companyList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: "Company",
                              prefixIcon:
                                  const Icon(Icons.business_center_rounded),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(children: [
                              Container(
                                height: 45,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.purple,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  //Start validation
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _formKey.currentState!.save();
                                      try {
                                        var res = await http.post(
                                            Uri.parse(API.empvalidation),
                                            body: {
                                              'company': '$selectedValue'
                                                  .toLowerCase(),
                                              'username': username_controller
                                                  .text
                                                  .trim(),
                                              'password': password_controller
                                                  .text
                                                  .trim(),
                                            });
                                        var result = json.decode(res.body);
                                        //Test responce
                                        //print(result);
                                        if (res.statusCode == 200 &&
                                            result['status'] == 'Y' &&
                                            result['p_status'] == 'success') {
                                          //on successful Auth redirect to home page
                                          var username =
                                              username_controller.text.trim();
                                          var company =
                                              '$selectedValue'.toLowerCase();
                                          // Saving login status
                                          saveLoginDetails(
                                              true, username, company);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                            (Route<dynamic> route) => false,
                                          );
                                        } else {
                                          //on wrong unsuccessful login error
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "! Invalid Username or Password"),
                                          ));
                                        }
                                      } catch (error) {
                                        // print error message
                                        Fluttertoast.showToast(
                                            msg: error.toString());
                                        print(error.toString());
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("! Invalid Details"),
                                      ));
                                    }
                                  },
                                  //End validation
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ]),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

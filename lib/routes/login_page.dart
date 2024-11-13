import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:employ_service/api/api_list.dart';
import 'package:employ_service/routes/home_page.dart';

// Save login status
Future<void> saveLoginDetails(bool isLoggedIn,String username,String company) async {
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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const LoginForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
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
  LoginFormState() {
    selectedValue = companyList[0];
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  const Text(
                    "Welcome Employee",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please login with your E-Urja Username and Password",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  const SizedBox(height: 20),
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.business_center_rounded),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextButton(
                      //Start validation
                      onPressed: () async {
                        //Test value
                        /*print('$selectedValue'.toLowerCase());
                        print(username_controller.text.trim());
                        print(password_controller.text.trim());*/

                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState!.save();
                          try {
                            var res = await http
                                .post(Uri.parse(API.empvalidation), body: {
                              'company': '$selectedValue'.toLowerCase(),
                              'username': username_controller.text.trim(),
                              'password': password_controller.text.trim(),
                            });
                            var result = json.decode(res.body);
                            //Test responce
                            //print(result);
                            if (res.statusCode == 200 &&
                                result['status'] == 'Y' &&
                                result['p_status'] == 'success') {
                              //on successful Auth redirect to home page
                              var username = username_controller.text.trim();
                              var company = '$selectedValue'.toLowerCase();
                              // Saving login status
                              saveLoginDetails(true,username,company);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            } else {
                              //on wrong unsuccessful login error
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("! Invalid Username or Password"),
                              ));
                            }
                          } catch (error) {
                            // print error message
                            Fluttertoast.showToast(msg: error.toString());
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:employ_service/api/api_list.dart';
import 'package:employ_service/routes/components/side_menu.dart';

class QuarterServiceComplaintPage extends StatelessWidget {
  const QuarterServiceComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Quarter Service Complaint',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quarter Service Complaint'),
        ),
        drawer: const SideMenu(),
        body: const QuarterServiceComplaintForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class QuarterServiceComplaintForm extends StatefulWidget {
  const QuarterServiceComplaintForm({super.key});

  @override
  QuarterServiceComplaintFormState createState() {
    return QuarterServiceComplaintFormState();
  }
}

// This class holds data related to the form.
class QuarterServiceComplaintFormState
    extends State<QuarterServiceComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory = '';
  List<String> CategoryList = ['Select Complaint Category'];
  String? selectedSubCategory = '';
  List<String> SubCategoryList = ['Select Complaint Sub Category'];
  QuarterServiceComplaintFormState() {
    selectedCategory = CategoryList[0];
    selectedSubCategory = SubCategoryList[0];
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
                    "Book Service Complaint",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please Select category and SubCategory of service complaint",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Category';
                      }
                      return null;
                    },
                    items: CategoryList.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "Category",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.build_outlined),
                    ),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: selectedSubCategory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedSubCategory = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Sub Category';
                      }
                      return null;
                    },
                    items: SubCategoryList.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "Sub Category",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.build_outlined),
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
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState!.save();
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
                            "Submit",
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

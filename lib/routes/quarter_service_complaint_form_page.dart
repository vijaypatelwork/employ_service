import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/api/api_list.dart';
import 'package:employ_service/routes/components/side_menu.dart';
import 'package:employ_service/routes/quarter_service_complaint_list_page.dart';

class QuarterServiceComplaintForm extends StatefulWidget {
  @override
  QuarterServiceComplaintFormState createState() =>
      QuarterServiceComplaintFormState();
}

class QuarterServiceComplaintFormState
    extends State<QuarterServiceComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedQuarter;
  List<DropdownMenuItem<String>> QuarterList = [];
  String? selectedCategory;
  List<DropdownMenuItem<String>> CategoryList = [];
  String? selectedSubCategory;
  List<DropdownMenuItem<String>> SubCategoryList = [];
  final complaint_details_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEmployeeQuarterDropdownData();
    fetchEmployeeCategoryDropdownData();
    fetchEmployeeSubcategoryDropdownData();
  }

  // get Prefrence Name
  Future<String> getPrefrenceName(String prefrenceName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefrenceValue = prefs.getString(prefrenceName) ?? '';
    return prefrenceValue;
  }

  // get Employee Quarter Sub Category API Data
  Future<void> fetchEmployeeQuarterDropdownData() async {
    final response = await http.get(Uri.parse(API.emp_quarter_details));
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      final items = (result as List).map((item) {
        return DropdownMenuItem<String>(
          value: item['id'].toString(),
          child: Text(item['quarterNo']),
        );
      }).toList();
      setState(() {
        QuarterList = items;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // get Employee Quarter Category API Data
  Future<void> fetchEmployeeCategoryDropdownData() async {
    final response = await http.get(Uri.parse(API.emp_quarter_category));
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      final items = (result as List).map((item) {
        return DropdownMenuItem<String>(
          value: item['id'].toString(),
          child: Text(item['categoryName']),
        );
      }).toList();
      setState(() {
        CategoryList = items;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // get Employee Quarter Sub Category API Data
  Future<void> fetchEmployeeSubcategoryDropdownData() async {
    var queryParams = {'category_id': selectedCategory};
    final Uri url = Uri.parse(API.emp_quarter_subcategory)
        .replace(queryParameters: queryParams);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      final items = (result as List).map((item) {
        return DropdownMenuItem<String>(
          value: item['id'].toString(),
          child: Text(item['subcategoryName']),
        );
      }).toList();
      setState(() {
        SubCategoryList = items;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> saveEmployeeQuarterComplaint(
      String quarter_id,
      String category_id,
      String subcategory_id,
      String complaint_status,
      String complaint_details) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String employee_id = prefs.getString('username') ?? '';
    var queryParams = {
      'employee_quarter_id': quarter_id,
      'employee_quarter_category_id': category_id,
      'employee_quarter_subcategory_id': subcategory_id,
      'employee_id': employee_id,
      'employee_quarter_complaint_status': complaint_status,
      'employee_quarter_complaint_details': complaint_details,
    };
    final Uri url = Uri.parse(API.emp_quarter_complaint_add)
        .replace(queryParameters: queryParams);
    var res = await http.get(url);
    var result = json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Quarter Service Complaint',
      home: Scaffold(
        appBar: AppBar(
          title: AutoSizeText('Quarter Service Complaint'),
        ),
        drawer: const SideMenu(),
        body: Form(
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
                      const AutoSizeText(
                        "Book Service Complaint",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AutoSizeText(
                        "Select category and SubCategory of service complaint",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: getPrefrenceName('empname'),
                        builder: (context, snapshot) {
                          return AutoSizeText('Employee name : '+'${snapshot.data}');
                        },
                      ),
                      FutureBuilder(
                        future: getPrefrenceName('empdesig'),
                        builder: (context, snapshot) {
                          return AutoSizeText('Employee Designation : '+'${snapshot.data}');},
                      ),
                      FutureBuilder(
                        future: getPrefrenceName('company'),
                        builder: (context, snapshot) {
                          return AutoSizeText('Employee Company : '+'${snapshot.data}');},
                      ),
                      const SizedBox(height: 30),
                      DropdownButtonFormField<String>(
                        value: selectedQuarter,
                        onChanged: (newValue) {
                          setState(() {
                            selectedQuarter = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select Your Quarter No';
                          }
                          return null;
                        },
                        items: QuarterList,
                        decoration: InputDecoration(
                          hintText: "Select Your Quarter No",
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
                        value: selectedCategory,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                            selectedSubCategory = null;
                            SubCategoryList = [];
                            fetchEmployeeSubcategoryDropdownData();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Select Complaint Category';
                          }
                          return null;
                        },
                        items: CategoryList,
                        decoration: InputDecoration(
                          hintText: "Select Complaint Category",
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
                            return 'Please Select Complaint Sub Category';
                          }
                          return null;
                        },
                        items: SubCategoryList,
                        decoration: InputDecoration(
                          hintText: "Select Complaint Sub Category",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.build_outlined),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: complaint_details_controller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Describe Your Complaint';
                          }
                          return null;
                        },
                        minLines: 6, // Set this
                        maxLines: 9, // and this
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Describe Your Complaint",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.build_outlined),
                        ),
                      )
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
                                  //Book complaint api Store data
                                  saveEmployeeQuarterComplaint(
                                      '$selectedQuarter',
                                      '$selectedCategory',
                                      '$selectedSubCategory',
                                      'pending',
                                      complaint_details_controller.text.trim());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            QuarterServiceComplaintList()),
                                  );
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
        ),
      ),
    );
  }
}

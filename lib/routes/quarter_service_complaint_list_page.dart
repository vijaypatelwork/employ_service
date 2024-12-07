import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/api/api_list.dart';
import 'package:employ_service/routes/components/side_menu.dart';
import 'package:employ_service/theme/app_theme.dart';

class QuarterServiceComplaintList extends StatefulWidget {
  @override
  QuarterServiceComplaintListState createState() =>
      QuarterServiceComplaintListState();
}

class QuarterServiceComplaintListState
    extends State<QuarterServiceComplaintList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  // get Employee Quarter Sub Category API Data
  Future<List<dynamic>> fetchEmployeeQuarterComplaintData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    var queryParams = {'employee_id': username};
    final Uri url = Uri.parse(API.emp_quarter_complaint)
        .replace(queryParameters: queryParams);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refresh() async {
    setState(() {
      fetchEmployeeQuarterComplaintData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      title: 'Employee Service',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: const SideMenu(),
        body: RefreshIndicator(
              onRefresh: _refresh,
              child: FutureBuilder<List<dynamic>>(
          // Fetch the data using the Future function
          future: fetchEmployeeQuarterComplaintData(),
          builder: (context, snapshot) {
            // Check if the Future is still loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            // Handle error if there was a problem fetching data
            if (snapshot.hasError) {
              return Center(child: AutoSizeText('Error: ${snapshot.error}'));
            }
            // Handle if data is fetched successfully
            if (snapshot.hasData) {
              List<dynamic> items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final itemNo = index + 1;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: AutoSizeText('[$itemNo] Your Complaint Details'),
                      subtitle: AutoSizeText('Quarter No : ${item['quarterNo']}'
                          '\nCategory : ${item['categoryName']}'
                          '\nSubcategory : ${item['subcategoryName']}'
                          '\nStatus : ${item['employee_quarter_complaint_status']}'
                          '\nDetails : ${item['employee_quarter_complaint_details']}'),
                    ),
                  );
                },
              );
            }
            return Center(child: AutoSizeText('No data available.'));
          },
        ),
        ),
      ),
    );
  }
}

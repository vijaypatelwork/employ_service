import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:employ_service/routes/components/side_menu.dart';
import 'package:employ_service/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> imageUrls = [
    'assets/images/banner_1.png',
    'assets/images/banner_2.png',
    'assets/images/banner_3.png',
  ];
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
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
    // Timer to automatically change the page every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    getPrefrenceName();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      title: 'Employee Service',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: null,
        drawer: const SideMenu(),
        body: CustomScrollView(
          slivers: <Widget>[
            // SliverAppBar with title and expanded header
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.apps),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              backgroundColor: Color(0xFFE4DAF4),
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Employee Suvidha Portal',
                    style: TextStyle(color: Color(0xFFFCF5FD))),
                collapseMode: CollapseMode.parallax,
                background: Container(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      // Display local images in the slider
                      return Image.asset(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),

            // SliverList with a list of items
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20),
                // Folders Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Services",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFolderCard("My Developments", "18.02.2018"),
                          _buildFolderCard("Dribbles", "21.06.2018"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Last Files Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Latest Updates",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),


                    ],
                  ),
                ),
              ]),
            ),
          ],

        ),
      ),
    );
  }
}


Widget _buildFolderCard(String title, String date) {
  return Container(
    width: 160,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.folder, color: Color(0xFF0074E4), size: 40),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Created: $date",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}
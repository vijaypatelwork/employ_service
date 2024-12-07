import 'package:flutter/material.dart';
import 'dart:async';
import 'package:employ_service/routes/components/side_menu.dart';


class TestApp extends StatefulWidget {
  @override
  SliverExample createState() => SliverExample();
}


class SliverExample extends State<TestApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> imageUrls = [
    'assets/images/banner_1.png',
    'assets/images/banner_2.png',
    'assets/images/banner_3.png',
  ];
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

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
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      key: _scaffoldKey,
      appBar: null,
      drawer: SideMenu(),
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
              title: Text('Employee Suvidha Portal',style: TextStyle(color: Color(0xFF664FA3))),
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
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
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item #$index'),
                );
              },
              childCount: 20,
            ),
          ),

          // SliverGrid with grid of items
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // Number of columns
              crossAxisSpacing: 10.0, // Horizontal space between items
              mainAxisSpacing: 10.0, // Vertical space between items
              childAspectRatio: 1.0, // Aspect ratio of each item
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      'Grid Item #$index',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    ),
    );
  }
}

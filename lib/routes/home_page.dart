import 'package:employ_service/routes/components/circular.dart';
import 'package:employ_service/routes/components/servicebutton.dart';
import 'package:employ_service/routes/quarter_service_complaint_list_page.dart';
import 'package:flutter/material.dart';
import 'package:employ_service/routes/components/side_menu.dart';
import 'package:employ_service/theme/app_theme.dart';
import 'package:employ_service/routes/components/custom_sliver_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var scrwidth = MediaQuery.of(context).size.width;
    var scrheight = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      title: 'Employee Service',
      home: Scaffold(
        appBar: null,
        drawer: SideMenu(),
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevents scrolling
                    crossAxisCount: (scrwidth ~/ 100) > 3
                        ? 3
                        : scrwidth ~/ 100, // Ensures a minimum of 1 count
                    children: [
                      ServiceButton(
                        icon: Icon(
                          Icons.health_and_safety,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 252, 43, 43),
                            Color.fromARGB(255, 247, 79, 37),
                            Color.fromARGB(255, 116, 17, 4)
                          ],
                        ),
                        index: 1,
                        text:
                            'E-Arogyam     Medical Benefits and Wellness Module(E-Arogyam',
                        press: () {},
                      ),
                      ServiceButton(
                        icon: Icon(
                          Icons.apartment,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 252, 74, 127),
                            Color.fromARGB(255, 145, 14, 75),
                            Color.fromARGB(255, 235, 37, 119)
                          ],
                        ),
                        index: 2,
                        text: 'Colony Maintainance',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuarterServiceComplaintList()),
                          );
                        },
                      ),
                      ServiceButton(
                        icon: Icon(
                          Icons.attractions,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 248, 160, 28),
                            Color.fromARGB(255, 207, 146, 65),
                            Color.fromARGB(255, 145, 74, 65)
                          ],
                        ),
                        index: 3,
                        text: 'Employee Self-Service',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Circular()),
                          );
                        },
                      ),
                      ServiceButton(
                        icon: Icon(
                          Icons.diversity_2,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 139, 5, 72),
                            Color.fromARGB(255, 207, 78, 100),
                            Color.fromARGB(255, 145, 74, 65)
                          ],
                        ),
                        index: 4,
                        text: 'Training Module',
                        press: () {},
                      ),
                      ServiceButton(
                        icon: Icon(
                          Icons.auto_stories,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 28, 99, 192),
                            Color.fromARGB(255, 70, 79, 161),
                            Color.fromARGB(255, 51, 29, 112)
                          ],
                        ),
                        index: 5,
                        text: 'Education Policy',
                        press: () {},
                      ),
                      ServiceButton(
                        icon: Icon(
                          Icons.directions_run_outlined,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 148, 6, 230),
                            Color.fromARGB(255, 140, 42, 185),
                            Color.fromARGB(255, 75, 5, 121)
                          ],
                        ),
                        index: 6,
                        text: 'Sports',
                        press: () {},
                      ),
                      ServiceButton(
                        icon: Icon(
                          Icons.dining_outlined,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 58, 36, 250),
                            Color.fromARGB(255, 93, 31, 163),
                            Color.fromARGB(255, 4, 26, 75)
                          ],
                        ),
                        index: 7,
                        text: 'Canteen Management',
                        press: () {},
                      ),
                      ServiceButton(
                        icon: Icon(
                          Icons.broadcast_on_home,
                          color: Colors.white,
                          size: 42,
                        ),
                        grd: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 245, 92, 65),
                            Color.fromARGB(255, 197, 107, 80),
                            Color.fromARGB(255, 75, 8, 4)
                          ],
                        ),
                        index: 8,
                        text: 'Communication Hub',
                        press: () {},
                      ),
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

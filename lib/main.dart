import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employ_service/routes/home_page.dart';
import 'package:employ_service/routes/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Check login status
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; // Store login status
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Employee Service',
      home: Scaffold(
        body: isLoggedIn ? HomePage() : LoginPage(),
      ),
    );
  }
}

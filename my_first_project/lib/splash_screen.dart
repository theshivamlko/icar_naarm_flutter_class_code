import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashbord.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Google_Gemini_logo.svg/1280px-Google_Gemini_logo.svg.png",
            width: 300,
          ),
          Padding(padding: EdgeInsets.all(20)),
          Text("Agri App", style: TextStyle(fontSize: 40, color: Colors.white)),
        ],
      ),
    );
  }

  void checkIfLoggedIn() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String email = ( sharedPreferences.getString("email")) ?? "";
    bool isLoggedIn = ( sharedPreferences.getBool("isLoggedIn")) ?? false;

    if (isLoggedIn) {
      // To open a page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard(email)),
      );
    } else {
      // To open a page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}

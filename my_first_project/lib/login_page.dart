import 'package:flutter/material.dart';
import 'package:my_first_project/dashbord.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8E44AD), // Purple
              Color(0xFFE74C3C), // Red
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with greeting
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu, color: Colors.white, size: 24),
                          Icon(Icons.more_vert, color: Colors.white, size: 24),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "Hello",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "Sign in!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom section with form
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        // Email Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "example@gmail.com",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.check, color: Colors.green, size: 20),
                              ),
                              style: TextStyle(fontSize: 16),
                              onChanged: (value) {
                                print(value);
                              },
                              onSubmitted: (value) {
                                email = value;
                                setState(() {});
                              },
                            ),
                            Divider(color: Colors.grey[300]),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "••••••••",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(fontSize: 16),
                              onChanged: (value) {
                                print(value);
                              },
                              onSubmitted: (value) {
                                password = value;
                                setState(() {});
                              },
                            ),
                            Divider(color: Colors.grey[300]),
                          ],
                        ),

                        SizedBox(height: 10),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Sign In Button
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF8E44AD),
                                Color(0xFFE74C3C),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(27.5),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              print("Login was clicked");
                              print("Email: ${emailController.text}");
                              print("Password: ${passwordController.text}");
                              sendToServer(emailController.text, passwordController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27.5),
                              ),
                            ),
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),

                        Spacer(),

                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account?",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle sign up
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Color(0xFF8E44AD),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendToServer(String email, String password) async {
    email = email.trim();

    if (email.isEmpty || password.isEmpty) {
      print("Email or Password is empty");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              "Error",
              style: TextStyle(
                color: Color(0xFF8E44AD),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Email or Password is empty",
              style: TextStyle(color: Colors.grey[700]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Color(0xFF8E44AD)),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    if (!email.contains("@")) {
      print("Email is invalid");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              "Invalid Email",
              style: TextStyle(
                color: Color(0xFF8E44AD),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Please enter a valid email address",
              style: TextStyle(color: Colors.grey[700]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Color(0xFF8E44AD)),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    if (password.length < 8) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              "Weak Password",
              style: TextStyle(
                color: Color(0xFF8E44AD),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Password must be at least 8 characters long",
              style: TextStyle(color: Colors.grey[700]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Color(0xFF8E44AD)),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", email);
    sharedPreferences.setBool("isLoggedIn", true);

    // To open a page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard(email)),
    );
  }
}
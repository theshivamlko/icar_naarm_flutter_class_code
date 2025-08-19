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
      appBar: AppBar(title: Text("Login Page"), backgroundColor: Colors.purple),
      body: Column(
        children: [
          Text("Login Form", style: TextStyle(fontSize: 30)),
          Text(email, style: TextStyle(fontSize: 18)),

          // Email Input Field
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                ),

                hintText: "Enter your email",
              ),
              onChanged: (value) {
                print(value);
              },
              onSubmitted: (value) {
                email = value;
                setState(() {});
              },
            ),
          ),

          // Blank Space
          Padding(padding: EdgeInsets.all(10)),

          // Password Input Field
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                ),

                hintText: "Enter your password",
              ),
              onChanged: (value) {
                print(value);
              },
              onSubmitted: (value) {
                password = value;
                setState(() {});
              },
            ),
          ),

          Container(
            color: Colors.red,
            width: 300,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                print("Login was clicked");
                print("Email: ${emailController.text}");
                print("Password: ${passwordController.text}");
                sendToServer(emailController.text, passwordController.text);
              },
              child: Text("Login"),
            ),
          ),
        ],
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
          return AlertDialog(backgroundColor: Colors.amber,
            content: Container(child: Text("Email or Password is empty")),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
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
          return AlertDialog(backgroundColor: Colors.amber,
            content: Container(child: Text("Email is invalid")),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
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
          return AlertDialog(backgroundColor: Colors.amber,
            content: Container(child: Text("Password must be at least 8 characters long")),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
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

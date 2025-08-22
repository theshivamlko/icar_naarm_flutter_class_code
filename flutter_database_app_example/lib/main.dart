import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MyHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD4p14vA1VwiVjH_4LIqbE3Rd4-VkRA1Zo",
      appId: "1:572040920731:android:a6d033ffd1703b01ab903e",
      messagingSenderId: "572040920731",
      projectId: "test-app-2nxfw7",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

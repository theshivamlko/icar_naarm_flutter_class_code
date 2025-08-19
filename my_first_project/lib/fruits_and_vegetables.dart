
import 'package:flutter/material.dart';

class FruitsAndVegetablesScreen extends StatefulWidget {
  const FruitsAndVegetablesScreen({super.key});

  @override
  State<FruitsAndVegetablesScreen> createState() => _FruitsAndVegetablesScreenState();
}

class _FruitsAndVegetablesScreenState extends State<FruitsAndVegetablesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruits and Vegetables"),
      ),
    );
  }
}

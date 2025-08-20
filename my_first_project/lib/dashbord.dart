import 'package:flutter/material.dart';
import 'package:my_first_project/splash_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'fruits_and_vegetables.dart';

class Dashboard extends StatefulWidget {
  String email = "";

  Dashboard(this.email, {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> titles = [
    "Major Fruits and Vegetables Producing Countries in the World from 2009-10 to 2012-13",
    "Area and Production of Vegetables during 2020-21",
    "Production of Different Crops during 2019-20",
    "Area under Different Crops (Provisional) during 2019-20",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              await sharedPreferences.clear();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.email,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),

            Padding(padding: EdgeInsets.all(12)),

            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("Clicked index $index");

                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FruitsAndVegetablesScreen(),
                          ),
                        );
                      } else if (index == 1) {
                        // Navigator.pushReplacement(context, AreaAndProductionData())
                      } else if (index == 2) {
                        // Navigator.pushReplacement(context, ProductionOfDifferentCropsData())
                      } else if (index == 3) {
                        // Navigator.pushReplacement(context, AreaUnderDifferentCropsData())
                      }
                    },
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  "https://img.freepik.com/premium-vector/landscaping-logo-white-background_1277164-20458.jpg?semt=ais_hybrid&w=740&q=80",
                                  height: 100,
                                  width: 100,
                                ),
                                Flexible(
                                  child: Text(
                                    titles[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {

                                      launchUrl(Uri.parse("https://linkedin.com/"));

                                    },
                                    icon: Icon(Icons.wifi),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      SharePlus.instance.share(
                                          ShareParams(text: titles[index])
                                      );
                                    },
                                    icon: Icon(Icons.share),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: titles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

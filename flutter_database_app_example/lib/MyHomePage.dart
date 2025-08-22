import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List cropsData = [];

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      fetchDataFromDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Firebase App Example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Crops Data", style: TextStyle(fontSize: 25)),
              Padding(padding: EdgeInsets.all(16)),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return getListItem(cropsData[index]);
                  },
                  itemCount: cropsData.length,
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getListItem(Map data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Country: ${data["country"]}", style: TextStyle(fontSize: 18)),
        Padding(padding: EdgeInsets.all(8)),
        Text(
          "Rank: #${data["rank"]}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(3)),
        Text(
          "Crops Name: ${data["crops_name"]}",
          style: TextStyle(fontSize: 16),
        ),
        Padding(padding: EdgeInsets.all(4)),
        Text("Area (Hectare): ${data["area"]}", style: TextStyle(fontSize: 16)),
        Padding(padding: EdgeInsets.all(4)),
        Divider(),
      ],
    );
  }

  Future fetchDataFromDB() async {
    print("fetchDataFromDB");
    try {
      DataSnapshot snapshot = await firebaseDatabase.ref("crops").get();


      if (snapshot.exists) {
        List response = snapshot.value as List;
        print("response=> ${response[0]["country"]}");

        cropsData = response;
        setState(() {

        });
      }
    }catch(e) {
      print("Exception=> ${e.toString()}");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class FruitsAndVegetablesScreen extends StatefulWidget {
  const FruitsAndVegetablesScreen({super.key});

  @override
  State<FruitsAndVegetablesScreen> createState() =>
      _FruitsAndVegetablesScreenState();
}

class _FruitsAndVegetablesScreenState extends State<FruitsAndVegetablesScreen> {
  Map<String, dynamic> responseMap = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fetchVegetablesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fruits and Vegetables")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading) Center(child: CircularProgressIndicator()),
            Text(
              responseMap["title"] ?? "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Padding(padding: EdgeInsets.all(16)),
            Text(
              "Organization Type: ${responseMap["org_type"] ?? ""}",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            Padding(padding: EdgeInsets.all(16)),
            Text(
              "Sectors : ",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),

            ...List.generate((responseMap["sector"]??[]).length, (index) {
              return Text(
                "${index + 1}. ${responseMap["sector"][index]}",
                style: TextStyle(fontSize: 16),
              );
            }).toList(),

            Expanded(
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [
                  DataColumn2(
                    label: Text(responseMap["field"][0]["name"]),
                    size: ColumnSize.L,
                  ),
                  DataColumn(label: Text(responseMap["field"][1]["name"])),
                  DataColumn(label: Text(responseMap["field"][3]["name"])),
                  DataColumn(label: Text(responseMap["field"][4]["name"])),
                  DataColumn(
                    label: Text(responseMap["field"][5]["name"]),
                    numeric: true,
                  ),
                ],
                rows: List<DataRow>.generate(
                  responseMap["records"].length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text(responseMap["records"][index]["category"])),
                      DataCell(Text(responseMap["records"][index]["country"])),
                      DataCell(
                        Text(
                          responseMap["records"][index]["area_in_hectare__2009_10"].toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          responseMap["records"][index]["area_in_hectare__2010_11"].toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          responseMap["records"][index]["area_in_hectare__2012_13"].toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchVegetablesData() async {
    Dio dio = Dio();
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    Response response = await dio.get(
      "https://api.data.gov.in/resource/d2dd1d29-048a-4963-b6e8-192a638819a9",
      queryParameters: {
        "api-key": "579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b",
        "format": "json",
      },
    );

    if (response.data != null) {
      print("Response => ${response.data}");

      responseMap = response.data;
    }
    setState(() {
      isLoading = false;
    });
  }
}

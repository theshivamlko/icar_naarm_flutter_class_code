import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:my_first_project/MyDatabase.dart';

class FruitsAndVegetablesScreen extends StatefulWidget {
  const FruitsAndVegetablesScreen({super.key});

  @override
  State<FruitsAndVegetablesScreen> createState() =>
      _FruitsAndVegetablesScreenState();
}

class _FruitsAndVegetablesScreenState extends State<FruitsAndVegetablesScreen>
    with TickerProviderStateMixin {
  Map<String, dynamic> responseMap = {};
  bool isLoading = false;
  String? errorMessage;

  late AnimationController _loadingController;

  MyDatabase myDatabase = MyDatabase();

  @override
  void initState() {
    super.initState();
    myDatabase.initialize();
    _setupAnimations();
    fetchVegetablesData();
  }

  void _setupAnimations() {

    _loadingController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();


  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: isLoading
                  ? _buildLoadingState()
                  : errorMessage != null
                  ? _buildErrorState()
                  : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00B894), Color(0xFF00CEC9)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00B894).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Agricultural Data",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Fruits & Vegetables",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.grass, color: Colors.white, size: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _loadingController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _loadingController.value * 2.0 * 3.14159,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00B894), Color(0xFF00CEC9)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.grass, color: Colors.white, size: 40),
                ),
              );
            },
          ),
          SizedBox(height: 30),
          Text(
            "Loading Agricultural Data...",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Please wait while we fetch the latest information",
            style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFE53E3E).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 60,
                color: Color(0xFFE53E3E),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Oops! Something went wrong",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            SizedBox(height: 10),
            Text(
              errorMessage ?? "Failed to load data",
              style: TextStyle(fontSize: 16, color: Color(0xFF718096)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  errorMessage = null;
                });
                fetchVegetablesData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00B894),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Try Again",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    print(responseMap.isEmpty);

    if (responseMap.isEmpty) {
      return _buildErrorState();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(),
          SizedBox(height: 20),
          _buildSectorsCard(),
          SizedBox(height: 20),
          _buildDataTable(),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF00B894).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: Color(0xFF00B894),
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Dataset Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            responseMap["title"] ?? "No title available",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A5568),
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF00B894).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Type: ${responseMap["org_type"] ?? "Government"}",
              style: TextStyle(
                color: Color(0xFF00B894),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectorsCard() {
    final sectors = responseMap["sector"] ?? [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF6C5CE7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.category, color: Color(0xFF6C5CE7), size: 24),
              ),
              SizedBox(width: 12),
              Text(
                "Sectors (${sectors.length})",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sectors.map<Widget>((sector) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  sector.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    final records = responseMap["records"] ?? [];
    final fields = responseMap["field"] ?? [];

    if (records.isEmpty || fields.isEmpty) {
      return _buildEmptyDataState();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFE17055).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.table_chart,
                    color: Color(0xFFE17055),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Production Data",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      Text(
                        "${records.length} records found",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF718096),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 400,
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 20,
              minWidth: 800,
              headingRowColor: MaterialStateProperty.all(Color(0xFFF7FAFC)),
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
                fontSize: 14,
              ),
              dataTextStyle: TextStyle(color: Color(0xFF4A5568), fontSize: 13),
              columns: [
                DataColumn2(
                  label: Text(fields[0]["name"] ?? "Category"),
                  size: ColumnSize.L,
                ),
                DataColumn(label: Text(fields[1]["name"] ?? "Country")),
                DataColumn(
                  label: Text(fields[3]["name"] ?? "2009-10"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(fields[4]["name"] ?? "2010-11"),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(fields[5]["name"] ?? "2012-13"),
                  numeric: true,
                ),
              ],
              rows: List<DataRow>.generate(records.length, (index) {
                final record = records[index];
                return DataRow(
                  color: MaterialStateProperty.resolveWith<Color?>((
                    Set<MaterialState> states,
                  ) {
                    if (index.isEven) {
                      return Color(0xFFF7FAFC).withOpacity(0.3);
                    }
                    return null;
                  }),
                  cells: [
                    DataCell(
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          record["category"]?.toString() ?? "-",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    DataCell(Text(record["country"]?.toString() ?? "-")),
                    DataCell(
                      Text(_formatNumber(record["area_in_hectare__2009_10"])),
                    ),
                    DataCell(
                      Text(_formatNumber(record["area_in_hectare__2010_11"])),
                    ),
                    DataCell(
                      Text(_formatNumber(record["area_in_hectare__2012_13"])),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyDataState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.table_chart, size: 60, color: Color(0xFFCBD5E0)),
          SizedBox(height: 16),
          Text(
            "No Data Available",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A5568),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "The dataset doesn't contain any records to display",
            style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatNumber(dynamic value) {
    if (value == null) return "-";
    final num = double.tryParse(value.toString());
    if (num == null) return value.toString();
    if (num >= 1000000) {
      return "${(num / 1000000).toStringAsFixed(1)}M";
    } else if (num >= 1000) {
      return "${(num / 1000).toStringAsFixed(1)}K";
    }
    return num.toStringAsFixed(0);
  }

  void fetchVegetablesData() async {
    try {
      Dio dio = Dio();
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      await Future.delayed(Duration(seconds: 1)); // Reduced delay

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

        myDatabase.insertData(
          responseMap["index_name"],
          responseMap["title"],
          responseMap["org_type"],
          jsonEncode(responseMap["sector"]),
            jsonEncode(responseMap["field"]),
            jsonEncode(responseMap["records"]),
        );
      } else {
        throw Exception("No data received from server");
      }
    } catch (e) {
      print("Error fetching data: $e");

      responseMap = await myDatabase.readData();
      print("Error fetching data: $responseMap");
      print("Error fetching data: ${responseMap["title"]}");
      print("Error fetching data: ${responseMap["sector"]}");
      if (responseMap.isNotEmpty) {
        errorMessage=null;
      } else {
        errorMessage =
            "Failed to load data. Please check your internet connection.";
      }
      setState(() {});
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

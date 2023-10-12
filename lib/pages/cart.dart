import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/cart_widget.dart';
import '../settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, dynamic> userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    final baseUrl = Apis.managementMainUrl;
    final apiUrl = baseUrl + 'pie_chart_data_for_cusotmers_api.php';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        final Map<String, dynamic> userResponse = responseData['data'];
        setState(() {
          userData = userResponse;
          isLoading = false;
        });
      } else {
        print('No "data" field in the response');
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double positiveValue =
        double.tryParse(userData['Positive'] ?? '0.0') ?? 0.0;
    double negativeValue =
        double.tryParse(userData['Negative'] ?? '0.0') ?? 0.0;

    final List<PieChartSectionData> pieChartData = [
      PieChartSectionData(
        color: Color.fromARGB(255, 0, 235, 31),
        value: positiveValue,
        title: positiveValue.toString() + " %",
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      PieChartSectionData(
        color: Color.fromARGB(255, 255, 17, 0),
        value: negativeValue,
        title: negativeValue.toString() + " %",
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: AppStyle.appBarTextColor),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: AppStyle.appBarBackgroundColor,
      ),
      backgroundColor: AppStyle.dashboardScreenBackgroundColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData.isEmpty
              ? Center(
                  child: Text(
                    'Data Not Found',
                    style:
                        TextStyle(color: AppStyle.packageOfferScreenTextColor),
                  ),
                )
              : buildUserProfile(pieChartData),
    );
  }

  Widget buildUserProfile(List<PieChartSectionData> pieChartData) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 5, 0, 0),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 10,
                  color: Colors.green, // Green color for Positive
                ),
                Text(
                  'Positive Call Rate',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // Add some space between the labels
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 10,
                  color: Colors.red, // Red color for Negative
                ),
                Text(
                  'Negative Call Rate',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
              height:
                  10), // Add some space between the labels and the pie chart
          PieChartWidget(pieChartData: pieChartData),
        ],
      ),
    );
  }
}

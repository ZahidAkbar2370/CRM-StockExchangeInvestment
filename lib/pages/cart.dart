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
        title: AppStyle.dashboardScreenChatLable1,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      PieChartSectionData(
        color: Color.fromARGB(255, 255, 17, 0),
        value: negativeValue,
        title: AppStyle.dashboardScreenChatLable2,
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
    return Container(
      child: PieChartWidget(pieChartData: pieChartData),
    );
  }
}

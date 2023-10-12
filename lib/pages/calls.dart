import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/tips.dart';
import '../settings.dart';

class CallsScreen extends StatefulWidget {
  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  List<Tips> tips = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    setState(() {
      isLoading = true;
    });

    final baseUrl = Apis.managementMainUrl;
    final apiUrl = baseUrl + 'stock-tips-call-api.php';
    final response = await http.get(Uri.parse(apiUrl));
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey("data")) {
        final List<dynamic> data = jsonResponse["data"];

        setState(() {
          tips = data.map((item) => Tips.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Data key not found in the API response');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print("no dta found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tips',
          style: TextStyle(color: AppStyle.appBarTextColor),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: AppStyle.appBarBackgroundColor,
      ),
      backgroundColor: AppStyle.callsScreenBackgroundColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tips.isEmpty
              ? Center(
                  child: Text(
                    'Data Not Found',
                    style:
                        TextStyle(color: AppStyle.packageOfferScreenTextColor),
                  ),
                )
              : ListView.builder(
                  itemCount: tips.length,
                  itemBuilder: (context, index) {
                    final tip = tips[index];
                    return ProductCard(
                      title: tip.sagment,
                      description: tip.ideas,
                      price: tip.timeStamp,
                    );
                  },
                ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;

  ProductCard({
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                description.length <= 200
                    ? description
                    : '${description.substring(0, 200)}...',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${price}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
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
}

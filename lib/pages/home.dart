import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> userData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch data or perform any other initialization logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: AppStyle.appBarTextColor),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: AppStyle.appBarBackgroundColor,
      ),
      backgroundColor: AppStyle.packageOfferScreenBackgroundColor,
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
          ),
          itemCount: 6, // Number of cards
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                color: Colors.black,
                child: InkWell(
                  onTap: () {
                    // Handle card tap
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/menu_${index + 1}.png', // Adjust the image path based on your asset structure
                        width: 50, // Adjust the width as needed
                        height: 50, // Adjust the height as needed
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        getMenuText(index),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String getMenuText(int index) {
    switch (index) {
      case 0:
        return 'System';
      case 1:
        return 'Files';
      case 2:
        return 'Marketing';
      case 3:
        return 'Communication';
      case 4:
        return 'Courses';
      default:
        return 'News';
    }
  }
}

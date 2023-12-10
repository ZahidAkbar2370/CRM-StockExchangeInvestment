import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../settings.dart';
import 'dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutScreen extends StatefulWidget {
  // final VoidCallback onLogout;

  // AboutScreen({
  //   required this.onLogout,
  // });

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // Map<String, dynamic> userData = {};
  // bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // fetchUserData();
  }

  // Future<int> getUserIdFromSession() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int userId = prefs.getInt('userId') ?? 0;
  //   return userId;
  // }

  // Future<void> fetchUserData() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   final baseUrl = Apis.clientMainUrl;
  //   int userId = await getUserIdFromSession();
  //   final apiUrl =
  //       baseUrl + 'client-details-api.php?clientid=' + userId.toString();
  //   final response = await http.get(Uri.parse(apiUrl));

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);

  //     if (responseData.containsKey('data')) {
  //       final Map<String, dynamic> userResponse = responseData['data'];
  //       setState(() {
  //         userData = userResponse;
  //         isLoading = false;
  //       });
  //     } else {
  //       print('No "data" field in the response');
  //     }
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _confirmLogout() async {
  //   final confirm = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Confirm Logout'),
  //         content: Text('Are you sure you want to logout?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(true);
  //             },
  //             child: Text('Yes'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(false);
  //             },
  //             child: Text('No'),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (confirm == true) {
  //     widget.onLogout();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(
      //   //   'About us',
      //   //   style: TextStyle(color: AppStyle.appBarTextColor),
      //   // ),
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Image.asset('assets/images/logo.png'),
      //   ),
      //   // backgroundColor: AppStyle.appBarBackgroundColor,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/about_us.png',
                  width: double.infinity,
                  // height: AppStyle.loginScreenLogoHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppStyle.loginScreenButtonBackgroundColor,
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // Set your desired radius
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      );
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: AppStyle.loginScreenButtonTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

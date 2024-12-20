import 'dart:convert';
import 'package:flutter/material.dart';
import 'otp.dart';
import '../components/error_dialog.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'package:http/http.dart' as http;
import '../settings.dart';
import 'tips.dart';
import 'dashboard.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.loginScreenBackgroundColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/images/login_logo.png',
                        width: AppStyle.loginScreenLogoWidth,
                        height: AppStyle.loginScreenLogoHeight,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStyle.loginScreenText,
                        style: TextStyle(
                          color: AppStyle.loginScreenTextColor,
                          fontSize: AppStyle.loginScreenTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: usernameController,
                        hintText: 'Mobile #',
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      Container(
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
                            signUserIn(context);
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: AppStyle.loginScreenButtonTextColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/images/trading_image.png',
                        // width: 900,
                        // height: AppStyle.loginScreenLogoHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> signUserIn(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final phone = usernameController.text;
    final password = passwordController.text;

    final baseUrl = Apis.clientMainUrl;
    final apiUrl = baseUrl + 'client-login-panel-api.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'Mobile': phone,
          'Password': password,
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userId = responseData['data']['Id'];
        final Mobile = responseData['data']['Mobile'];
        await saveUserIdInSession(userId, Mobile);

        usernameController.text = '';
        passwordController.text = '';

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        showErrorDialog(
          context,
          'Login Failed',
          'Invalid! Please try again.',
        );

        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> saveUserIdInSession(int userId, String Mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('Mobile', Mobile);
  }
}

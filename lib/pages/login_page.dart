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
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'assets/images/logo.png',
                      width: AppStyle.loginScreenLogoWidth,
                      height: AppStyle.loginScreenLogoHeight,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      AppStyle.loginScreenText,
                      style: TextStyle(
                        color: AppStyle.loginScreenTextColor,
                        fontSize: AppStyle.loginScreenTextSize,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Mobile #',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppStyle.loginScreenButtonBackgroundColor),
                        ),
                        onPressed: () {
                          signUserIn(context);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppStyle.loginScreenButtonTextColor,
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

  Future<void> signUserIn(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final phone = usernameController.text;
    final password = passwordController.text;

    final baseUrl = Apis.clientMainUrl;
    final apiUrl = baseUrl + 'client_login_panel_api.php';

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
        await saveUserIdInSession(userId);

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

  Future<void> saveUserIdInSession(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }
}

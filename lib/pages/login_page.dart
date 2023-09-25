import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/otp.dart';
import '../components/error_dialog.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../settings.dart';
import 'tips.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUserIn(BuildContext context) async {
    final phone = usernameController.text;
    final password = passwordController.text;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OTPScreen()));
    // Replace with your API endpoint URL
    final apiUrl = 'https://fakestoreapi.com/auth/login'; // Update this URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        usernameController.text = '';
        passwordController.text = '';
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OTPScreen()));
        // }
      } else {
        showErrorDialog(
          context,
          'Login Failed',
          'Invalid! Please try again.',
        );
      }
    } catch (error) {
      // Handle network or other errors here
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.loginScreenBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ... (existing UI code)
              const SizedBox(height: 50),

              // logo
              // const Icon(
              //   Icons.lock,
              //   size: 100,
              //   color: Color.fromARGB(255, 255, 255, 255),
              // ),

              Image.asset(
                'assets/images/main_logo.png',
                width: AppStyle.loginScreenLogoWidth,
                height: AppStyle.loginScreenLogoHeight,
                color: Color.fromARGB(255, 255, 255, 255),
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                AppLocalizations.of(context)!.appName,
                style: TextStyle(
                  color: AppStyle.loginScreenTextColor,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  signUserIn(context);
                },
                child: Text(
                    'Sign In'), // Change 'Sign In' to your desired button label
              )
            ],
          ),
        ),
      ),
    );
  }
}

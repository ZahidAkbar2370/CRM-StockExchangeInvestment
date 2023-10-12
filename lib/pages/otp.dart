import 'package:flutter/material.dart';
import 'tips.dart';
import 'dashboard.dart';
import 'package:get/get.dart';
import '../settings.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();

  void verifyOTP() {
    String enteredOTP = otpController.text;
    String generatedOTP =
        "123456"; // Replace with the actual OTP sent to the user

    if (enteredOTP == generatedOTP) {
      // OTP is correct, navigate to the next screen
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen()));
      // Get.to(TipsScreen());
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => TipsScreen(), // Replace with your next screen
      //   ),
      // );
    } else {
      // OTP is incorrect, display an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid OTP. Please try again.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStyle.otpScreenText,
              style: TextStyle(
                fontSize: AppStyle.otpScreenTextSize,
                color: AppStyle.otpScreenTextColor,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyle
                    .otpScreenButtonBackgroundColor, // Set the background color here
              ),
              onPressed: verifyOTP,
              child: Text(
                'Verify OTP',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

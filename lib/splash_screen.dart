import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds and then navigate to the login page
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Change to your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitChasingDots(
              color: Colors
                  .white, // Change to your desired loading animation color
              size: 50.0, // Change to your desired loading animation size
            ),
            SizedBox(height: 16.0),
            Text(
              'My App',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white, // Change to your desired text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

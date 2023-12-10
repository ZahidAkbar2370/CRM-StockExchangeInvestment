import 'package:flutter/material.dart';
import 'pages/dashboard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'pages/login_page.dart';
import 'settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      checkUserAndNavigate();
    });
  }

  Future<void> checkUserAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    if (userId != null && userId != 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  AppStyle.loginScreenText,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: AppStyle.loginScreenTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/logo.png',
                  width: 170,
                  // height: AppStyle.loginScreenLogoHeight,
                ),
                // const SizedBox(height: 4),
                Image.asset(
                  'assets/images/progress_bar.png',
                  width: AppStyle.loginScreenLogoWidth,
                  height: AppStyle.loginScreenLogoHeight,
                ),
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/splash_image.png',
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
}





// import 'package:flutter/material.dart';
// import 'pages/dashboard.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'pages/login_page.dart';
// import 'settings.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 5), () {
//       checkUserAndNavigate();
//     });
//   }

//   Future<void> checkUserAndNavigate() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int userId = prefs.getInt('userId') ?? 0;

//     if (userId != null && userId != 0) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => DashboardScreen()),
//       );
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppStyle.splashScreenBackgroundColor,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SpinKitChasingDots(
//               color: AppStyle.splashScreenLoderColor,
//               size: AppStyle.splashScreenLoderSize,
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               AppStyle.splashScreenText,
//               style: TextStyle(
//                 fontSize: AppStyle.splashScreenTextFontSize,
//                 color: AppStyle.splashScreenTextColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

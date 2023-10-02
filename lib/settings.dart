import 'package:flutter/material.dart';

class AppStyle {
  static const Color primaryColor = Colors.white;
  static const Color secondaryColor = Colors.blueGrey;
  static const Color dangerColor = Colors.redAccent;
  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.yellow;
  static const Color whiteTextColor = Colors.white;
  static const Color blackTextColor = Colors.black;

/* 
.
.
. Splash Screen
.
.
*/
  static const Color splashScreenBackgroundColor = Colors.green;
  static const Color splashScreenLoderColor = Color.fromARGB(255, 175, 76, 76);
  static const double splashScreenLoderSize = 50;
  static const String splashScreenText = "Anil CRM";
  static const double splashScreenTextFontSize = 20;
  static const Color splashScreenTextColor = Colors.white;

/* 
.
.
. Login Screen
.
.
*/
  static const Color loginScreenBackgroundColor = Colors.green;
  static const double loginScreenLogoWidth = 200;
  static const double loginScreenLogoHeight = 50;
  static const Color loginScreenTextColor = Colors.white;
  static const String loginScreenText = 'Welcome TO CRM';
  static const double loginScreenTextSize = 20;

  /* 
.
.
. OTP Screen
.
.
*/
  static const Color otpScreenBackgroundColor = Colors.green;
  static const Color otpScreenButtonBackgroundColor =
      Color.fromARGB(255, 224, 39, 6);
  static const Color otpScreenTextColor = Colors.white;
  static const String otpScreenText = 'Enter OTP';
  static const double otpScreenTextSize = 20;

  /* 
.
.
. Bottom Nav Bar
.
.
*/
  static const Color bototmNavbarBackgroundColor = Colors.green;
  static const Color bototmNavbarItemBackgroundColor = Colors.green;
  static const Color bototmNavbarItemColor = Color.fromARGB(255, 97, 76, 175);
  static const Color bototmNavbarActiveItemColor =
      Color.fromARGB(255, 240, 240, 240);
  static const Color bototmNavbarActiveItemBackgroundColor =
      Color.fromARGB(255, 0, 0, 0);

/* 
.
.
. Dashboard Screen
.
.
*/
  static const Color dashboardScreenBackgroundColor =
      Color.fromARGB(255, 91, 76, 175);

/* 
.
.
. Calls/Tips Screen
.
.
*/
  static const Color callsScreenBackgroundColor =
      Color.fromARGB(255, 91, 76, 175);

/* 
.
.
. Calls/Tips Screen
.
.
*/
  static const Color packageOfferScreenBackgroundColor =
      Color.fromARGB(255, 91, 76, 175);
}

class Apis {
  static const String mainUrl = "https://softwebies.com";
}

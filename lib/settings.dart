import 'package:flutter/material.dart';

class AppStyle {
  static const Color primaryColor = Color(0xFFF7CE4D);
  // static const Color secondaryColor = Colors.blueGrey;
  static const Color dangerColor = Colors.redAccent;
  static const Color successColor = Colors.green;
  // static const Color warningColor = Colors.yellow;
  static const Color whiteTextColor = Colors.white;
  static const Color blackTextColor = Colors.black;

/* 
.
.
. Splash Screen
.
.
*/
  static const Color splashScreenBackgroundColor = primaryColor;
  static const Color splashScreenLoderColor = whiteTextColor;
  static const double splashScreenLoderSize = 50;
  static const String splashScreenText = "Best Stock Advisor";
  static const double splashScreenTextFontSize = 20;
  static const Color splashScreenTextColor = whiteTextColor;

/* 
.
.
. Login Screen
.
.
*/
  static const Color loginScreenBackgroundColor = Color(0xFFF7CE4D);
  static const double loginScreenLogoWidth = 200;
  static const double loginScreenLogoHeight = 100;
  static const Color loginScreenTextColor = whiteTextColor;
  static const String loginScreenText = 'Best Stock Advisor';
  static const double loginScreenTextSize = 20;

  static const Color loginScreenButtonBackgroundColor = blackTextColor;
  static const Color loginScreenButtonTextColor = whiteTextColor;

  /* 
.
.
. AppBar
.
.
*/
  static const Color appBarBackgroundColor = primaryColor;
  static const Color appBarTextColor = whiteTextColor;

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
  static const Color bototmNavbarBackgroundColor = Color(0xFFF7CE4D);
  static const Color bototmNavbarItemBackgroundColor = Color(0xFFF7CE4D);
  static const Color bototmNavbarItemColor = whiteTextColor;
  static const Color bototmNavbarActiveItemColor = blackTextColor;
  static const Color bototmNavbarActiveItemBackgroundColor = whiteTextColor;
  static const String dashboardScreenChatLable1 = 'Positive Calls Rate %';
  static const String dashboardScreenChatLable2 = 'Nagitive Calls Rate %';

/* 
.
.
. Dashboard Screen
.
.
*/
  static const Color dashboardScreenBackgroundColor = whiteTextColor;

/* 
.
.
. Calls/Tips Screen
.
.
*/
  static const Color callsScreenBackgroundColor = whiteTextColor;

/* 
.
.
. Package Offer Screen
.
.
*/
  static const Color packageOfferScreenBackgroundColor = whiteTextColor;

  static const Color packageOfferScreenTextColor = blackTextColor;

  /* 
.
.
. Logout Screen
.
.
*/
  static const Color logoutScreenButtonBackgroundColor = primaryColor;
  static const Color logoutScreenButtonTextColor = whiteTextColor;
}

class Apis {
  static const String clientMainUrl = "https://client.beststockadvisor.co.in/";
  static const String managementMainUrl =
      "https://management.beststockadvisor.co.in/";
}

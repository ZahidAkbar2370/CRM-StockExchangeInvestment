import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/dashboard.dart';
import 'pages/tips.dart';
import 'splash_screen.dart';
import 'pages/calls.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

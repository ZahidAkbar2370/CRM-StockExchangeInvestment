import 'package:flutter/material.dart';
import '../splash_screen.dart';
import 'tips.dart';
import 'profile.dart';
import 'cart.dart';
import 'calls.dart';
import 'drawer.dart';
import 'payment_history.dart';
import 'home.dart';
import 'package_offer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        color: AppStyle.bototmNavbarBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: GNav(
            backgroundColor: AppStyle.bototmNavbarItemBackgroundColor,
            color: AppStyle.bototmNavbarItemColor,
            activeColor: AppStyle.bototmNavbarActiveItemColor,
            tabBackgroundColor: AppStyle.bototmNavbarActiveItemBackgroundColor,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });

              if (index == 5) {
                // Open drawer when "Menu" tab is clicked
                _scaffoldKey.currentState!.openDrawer();
              } else {
                // Switch to the selected page
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }

              // _pageController.animateToPage(
              //   index,
              //   duration: Duration(milliseconds: 300),
              //   curve: Curves.ease,
              // );
            },
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                // text: "Home",
                // textStyle: TextStyle(fontSize: 10),
              ),
              GButton(
                icon: Icons.dashboard,
                // text: "Dashboard",
                // textStyle: TextStyle(fontSize: 10),
              ),
              // GButton(
              //   icon: Icons.lightbulb_outline,
              // ),
              GButton(
                icon: Icons.call,
                // text: "Tips",
                // textStyle: TextStyle(fontSize: 10),
              ),
              GButton(
                // icon: Icons.local_offer,
                icon: Icons.attach_money,
                // text: "Package & Payment",
                // textStyle: TextStyle(fontSize: 10),
              ),

              GButton(
                icon: Icons.account_circle,
                // text: "Profile",
                // textStyle: TextStyle(fontSize: 10),
              ),
              GButton(
                icon: Icons.menu,
              ),
            ],
            selectedIndex: _selectedIndex,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeScreen(),
          Container(child: CartScreen()),
          // TipsScreen(),
          CallsScreen(),
          PackageOfferScreen(),
          // PaymentHistoryScreen(),
          ProfileScreen(
            onLogout: () {
              clearUserIdFromSession();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            },
          ),
          // Container(child: MyDrawer()),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Future<void> clearUserIdFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }
}

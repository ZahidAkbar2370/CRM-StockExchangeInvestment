import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tips.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/cart.dart';
import 'package:flutter_application_1/pages/calls.dart';
import 'package:flutter_application_1/pages/payment_history.dart';
import 'package:flutter_application_1/pages/package_offer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../settings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // You can also use _pageController.jumpToPage(index); for immediate page change.
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.dashboard,
              ),
              // GButton(
              //   icon: Icons.lightbulb_outline,
              // ),
              GButton(
                icon: Icons.call,
              ),
              GButton(
                icon: Icons.local_offer,
              ),
              GButton(
                icon: Icons.attach_money,
              ),
              GButton(
                icon: Icons.account_circle,
              ),
            ],
            selectedIndex: _selectedIndex,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          // Replace these with your actual screens for each tab.
          Container(child: CartScreen()),
          // TipsScreen(),
          CallsScreen(),
          PackageOfferScreen(),
          PaymentHistoryScreen(),
          ProfileScreen(
            onLogout: () {
              // Implement logout functionality here
              // For example, you can navigate back to the login page
              Navigator.pushReplacementNamed(
                  context, '/login'); // Replace with your login route
            },
          ),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

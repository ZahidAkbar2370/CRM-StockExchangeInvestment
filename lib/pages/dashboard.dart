import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tips.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/cart.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
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
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.favorite_border, text: 'Tips'),
              GButton(icon: Icons.search, text: 'Calls'),
              GButton(icon: Icons.settings, text: 'Settings'),
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
          TipsScreen(),
          Container(child: Text("Calls Screen")),
          Container(
            child: ProfileScreen(
              name: 'John Doe', // Replace with actual user data
              email: 'johndoe@example.com',
              phoneNumber: '123-456-7890',
              onLogout: () {
                // Implement logout functionality here
                // For example, you can navigate back to the login page
                Navigator.pushReplacementNamed(
                    context, '/login'); // Replace with your login route
              },
            ),
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

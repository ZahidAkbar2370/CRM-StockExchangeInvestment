import 'package:flutter/material.dart';
import 'dashboard.dart';
import '/pages/home.dart';
import '/pages/about_us.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  // height: AppStyle.loginScreenLogoHeight,
                ),
                Text(
                  'Best Stock Advisor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to the home screen or perform other actions
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              ); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About us'),
            onTap: () {
              // Navigate to the settings screen or perform other actions
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              ); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}

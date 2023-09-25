import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final VoidCallback onLogout;

  ProfileScreen({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Phone Number: $phoneNumber'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onLogout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

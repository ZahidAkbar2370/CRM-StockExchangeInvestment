import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentHistoryScreen extends StatefulWidget {
  // final VoidCallback onLogout;

  // PaymentHistoryScreen({
  //   required this.onLogout,
  // });

  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  Map<String, dynamic> userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/users/1'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        userData = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error here
    }
  }

  Future<void> _confirmLogout() async {
    final confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm logout
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel logout
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );

    // if (confirm == true) {
    //   // User confirmed logout
    //   widget.onLogout();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData.isEmpty
              ? Center(child: Text('Failed to load user data'))
              : buildUserProfile(),
    );
  }

  Widget buildUserProfile() {
    final name =
        userData['name']['firstname'] + ' ' + userData['name']['lastname'];
    final email = userData['email'];
    final phoneNumber = userData['phone'];

    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://placekitten.com/100/100'), // Replace with your profile image URL
            ),
            title: Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              email,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(), // A divider line
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              'Phone Number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              phoneNumber,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _confirmLogout,
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

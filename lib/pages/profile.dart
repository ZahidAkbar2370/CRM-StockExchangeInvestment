import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onLogout;

  ProfileScreen({
    required this.onLogout,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<int> getUserIdFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;
    return userId;
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    final baseUrl = Apis.clientMainUrl;
    int userId = await getUserIdFromSession();
    final apiUrl =
        baseUrl + 'client-details-api.php?clientid=' + userId.toString();
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        final Map<String, dynamic> userResponse = responseData['data'];
        setState(() {
          userData = userResponse;
          isLoading = false;
        });
      } else {
        print('No "data" field in the response');
      }
    } else {
      setState(() {
        isLoading = false;
      });
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
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      widget.onLogout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: AppStyle.appBarTextColor),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: AppStyle.appBarBackgroundColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData.isEmpty
              ? Center(child: Text('Failed to load user data'))
              : buildUserProfile(),
    );
  }

  Widget buildUserProfile() {
    final name = userData['User'] ?? '';
    final email = userData['Email'] ?? '';
    final phoneNumber = userData['Mobile'] ?? '';
    final deviceType = userData['device_type'] ?? 'null';
    final passwordChangedDate = userData['Password_Changed_Date'] ?? 'null';
    final timesTamp = userData['Timestamp'] ?? '';

    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://placekitten.com/100/100'),
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

          Divider(), // A divider line
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text(
              'Time Stamp:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              timesTamp,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(), // A divider line
          ListTile(
            leading: Icon(Icons.lock),
            title: Text(
              'Password Change Date:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              passwordChangedDate,
              style: TextStyle(fontSize: 16),
            ),
          ),

          Divider(), // A divider line
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text(
              'Device Type:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              deviceType,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 40),
          Container(
            width: 300,
            height: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  AppStyle.loginScreenButtonBackgroundColor,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25.0), // Set your desired radius
                  ),
                ),
              ),
              onPressed: _confirmLogout,
              child: Text(
                'LOGOUT',
                style: TextStyle(
                  color: AppStyle.loginScreenButtonTextColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all<Color>(
          //         AppStyle.logoutScreenButtonBackgroundColor),
          //   ),
          //   onPressed: _confirmLogout,
          //   child: Text(
          //     'Logout',
          //     style: TextStyle(color: AppStyle.logoutScreenButtonTextColor),
          //   ),
          // ),
        ],
      ),
    );
  }
}

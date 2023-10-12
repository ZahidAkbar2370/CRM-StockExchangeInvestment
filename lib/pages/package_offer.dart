import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageOfferScreen extends StatefulWidget {
  @override
  _PackageOfferScreenState createState() => _PackageOfferScreenState();
}

class _PackageOfferScreenState extends State<PackageOfferScreen> {
  List<Map<String, dynamic>> userData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<String> getUserIdFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('Mobile') ?? '0';
    return userId;
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    final baseUrl = Apis.managementMainUrl;
    String userId = await getUserIdFromSession();
    print("user_id ${userId}");

    final apiUrl = baseUrl +
        'customer-payment-history-api.php?Mobile=' +
        userId.toString();
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('status') && data['status'] == false) {
        print('Data Not Found: ${data["message"]}');
        setState(() {
          isLoading = false;
        });
      } else if (data.containsKey('data') && data['data'] is List<dynamic>) {
        final List<Map<String, dynamic>> dataList = List.castFrom(data['data']);
        setState(() {
          userData = dataList;
          isLoading = false;
        });
      } else {
        print('Invalid data format: Not a List of Maps');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Package Offer',
          style: TextStyle(color: AppStyle.appBarTextColor),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        backgroundColor: AppStyle.appBarBackgroundColor,
      ),
      backgroundColor: AppStyle.packageOfferScreenBackgroundColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData.isEmpty
              ? Center(
                  child: Text(
                    'Data Not Found',
                    style:
                        TextStyle(color: AppStyle.packageOfferScreenTextColor),
                  ),
                )
              : buildUserProfile(),
    );
  }

  Widget buildUserProfile() {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (BuildContext context, int index) {
        final user = userData[index];
        final FullName = user['Full_Name'] ?? '';
        final PackageName = user['PackageName'] ?? '';
        final PaymentMode = user['PaymentMode'] ?? '';
        final Paid_Amout = user['Paid_Amout'] ?? '';
        final Company_Amount = user['Company_Amount'] ?? '';
        final Tax_Amount = user['Tax_Amount'] ?? '';
        final SaleDate = user['SaleDate'] ?? '';
        final Exp_Date = user['Exp_Date'] ?? '';

        return Container(
          height: 400,
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.local_offer),
                  title: Text(
                    PackageName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    FullName,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Payment Mode:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            PaymentMode,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Paid Amount:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Paid_Amout.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // second column
                Divider(),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Company Amount:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Company_Amount.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Tax Amount:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Tax_Amount.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // third column
                Divider(),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Sale Date:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            SaleDate.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Exp Date:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Exp_Date.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget buildUserProfile() {

  //   final FullName = userData['Full_Name'] ?? '';
  //   final PackageName = userData['PackageName'] ?? '';
  //   final PaymentMode = userData['PaymentMode'] ?? '';
  //   final Paid_Amout = userData['Paid_Amout'] ?? '';
  //   final Company_Amount = userData['Company_Amount'] ?? '';
  //   final Tax_Amount = userData['Tax_Amount'] ?? '';
  //   final SaleDate = userData['SaleDate'] ?? '';
  //   final Exp_Date = userData['Exp_Date'] ?? '';

  //   return Container(
  //     height: 400,
  //     child: Card(
  //       margin: EdgeInsets.all(16.0),
  //       child: Column(
  //         children: <Widget>[
  //           ListTile(
  //             leading: Icon(Icons.local_offer),
  //             title: Text(
  //               PackageName,
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             subtitle: Text(
  //               FullName,
  //               style: TextStyle(fontSize: 16),
  //             ),
  //           ),
  //           Divider(),
  //           Padding(
  //             padding: EdgeInsets.all(10.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       'Payment Mode:',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       PaymentMode,
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       'Paid Amount:',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       Paid_Amout.toString(),
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           // second column
  //           Divider(),
  //           Padding(
  //             padding: EdgeInsets.all(10.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       'Company Amount:',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       Company_Amount.toString(),
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       'Tax Amount:',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       Tax_Amount.toString(),
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           // third column
  //           Divider(),
  //           Padding(
  //             padding: EdgeInsets.all(10.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       'Sale Date:',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       SaleDate.toString(),
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       'Exp Date:',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     Text(
  //                       Exp_Date.toString(),
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

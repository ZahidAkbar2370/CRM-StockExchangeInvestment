// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/tips.dart';

// class TipsScreen extends StatefulWidget {
//   @override
//   _TipsScreenState createState() => _TipsScreenState();
// }

// class _TipsScreenState extends State<TipsScreen> {
//   List<Tips> tips = [];
//   bool isLoading = false;

//   DateTime? fromDate;
//   DateTime? toDate;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromApi();
//   }

//   Future<void> fetchDataFromApi() async {
//     setState(() {
//       isLoading = true; // Start loading
//     });

//     final response =
//         await http.get(Uri.parse('https://fakestoreapi.com/products'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);

// // final filteredTips = tips
// //           .where((tip) =>
// //               (fromDate == null || tip.date.isAfter(fromDate!)) &&
// //               (toDate == null || tip.date.isBefore(toDate!)))
// //           .toList();

//       setState(() {
//         tips = data.map((item) => Tips.fromJson(item)).toList();
//         // tips = filteredTips;
//         isLoading = false; // Stop loading
//       });
//     } else {
//       throw Exception('Failed to load data from the API');
//     }
//   }

//   Future<void> _selectFromDate(BuildContext context) async {
//     final selectedDate = await showDatePicker(
//       context: context,
//       initialDate: fromDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (selectedDate != null) {
//       setState(() {
//         fromDate = selectedDate;
//       });
//     }
//   }

//   Future<void> _selectToDate(BuildContext context) async {
//     final selectedDate = await showDatePicker(
//       context: context,
//       initialDate: toDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (selectedDate != null) {
//       setState(() {
//         toDate = selectedDate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tips'),
//       ),
//       body: Column(
//         children: <Widget>[
//           // Date Filters
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   _selectFromDate(context);
//                 },
//                 child: Text(
//                   'From Date: ${fromDate?.toLocal()}'.split(' ')[0],
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   _selectToDate(context);
//                 },
//                 child: Text(
//                   'To Date: ${toDate?.toLocal()}'.split(' ')[0],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   fetchDataFromApi(); // Trigger data fetching with filters
//                 },
//                 child: Text('Search'),
//               ),
//             ],
//           ),

//           // Display selected dates
//           if (fromDate != null && toDate != null)
//             Text(
//               'Selected Date Range: ${fromDate!.toLocal()} - ${toDate!.toLocal()}',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),

//           // Loading Indicator or Data
//           isLoading
//               ? Center(
//                   child: CircularProgressIndicator()) // Show loading indicator
//               : Expanded(
//                   child: ListView.builder(
//                     itemCount: tips.length,
//                     itemBuilder: (context, index) {
//                       final tip = tips[index];
//                       return ProductCard(
//                         title: tip.title,
//                         description: tip.description,
//                         price: "2",
//                       );
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String price;

//   ProductCard({
//     required this.title,
//     required this.description,
//     required this.price,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       child: Card(
//         margin: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ListTile(
//               title: Text(
//                 title,
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 description.length <= 200
//                     ? description
//                     : '${description.substring(0, 200)}...',
//                 style: TextStyle(fontSize: 16.0),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Price: $price',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

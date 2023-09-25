import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  // Replace this with your actual data
  final List<PieChartSectionData> pieChartData = [
    PieChartSectionData(
      color: Colors.blue,
      value: 30, // Replace with your data values
      title: 'Label 1',
    ),
    PieChartSectionData(
      color: Colors.green,
      value: 40, // Replace with your data values
      title: 'Label 2',
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 20, // Replace with your data values
      title: 'Label 3',
    ),
  ];

  final List<PieChartSectionData> pieChartData1 = [
    PieChartSectionData(
      color: Colors.blue,
      value: 30, // Replace with your data values
      title: 'Label 1',
    ),
    PieChartSectionData(
      color: Colors.green,
      value: 40, // Replace with your data values
      title: 'Label 2',
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 20, // Replace with your data values
      title: 'Label 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Use the PieChartWidget here
            PieChartWidget(pieChartData: pieChartData),
            PieChartWidget(pieChartData: pieChartData1),
            // Add other cart content here
          ],
        ),
      ),
    );
  }
}

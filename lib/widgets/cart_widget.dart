import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final List<PieChartSectionData> pieChartData;

  PieChartWidget({required this.pieChartData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          PieChart(
            PieChartData(
              sections: pieChartData,
              borderData: FlBorderData(show: false),
              centerSpaceRadius: 80,
              sectionsSpace: 1,
            ),
          ),
        ],
      ),
    );
  }
}

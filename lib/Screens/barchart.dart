import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatelessWidget {
  final List<BarChartGroupData> barGroups = [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 3,
          color: Colors.blue,
        ),
      ],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 5,
          color: Colors.red,
        ),
      ],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 4,
          color: Colors.green,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: barGroups,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class WeekData {
  final double totalMark;
  final String reviewName;

  WeekData(this.totalMark, this.reviewName);
}

class ProgressScreen extends StatefulWidget {
  final String uid;

  const ProgressScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(widget.uid)
            .collection('weeks')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot<Map<String, dynamic>>> weeks =
              snapshot.data!.docs;

          List<WeekData> weekDataList = weeks.map((week) {
            var data = week.data();
            var totalMark = double.tryParse(data['totalMark'] ?? '0.0') ?? 0.0;
            var reviewName = data['reviewName'] ?? 'Not uploaded';
            return WeekData(totalMark, reviewName);
          }).toList();

          List<FlSpot> spots = List.generate(
            weekDataList.length,
            (index) {
              return FlSpot(index.toDouble(), weekDataList[index].totalMark);
            },
          );

          return LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: const FlTitlesData(
                show: true,
                leftTitles: AxisTitles(),
                bottomTitles: AxisTitles(),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue,
                  dotData: const FlDotData(
                    show: true,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color(0xff1f005c),
                        Color(0xff5b0060),
                        Color(0xff870160),
                        Color(0xffac255e),
                        Color(0xffca485c),
                        Color(0xffe16b5c),
                        Color(0xfff39060),
                        Color(0xffffb56b),
                      ],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
              ],
              minX: 0,
              maxX: weekDataList.length.toDouble() - 1,
              minY: 0,
              maxY: 30, // Adjust this value based on your data
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.blueAccent,
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((barSpot) {
                      final flSpot = spots[barSpot.spotIndex];
                      final weekData = weekDataList[barSpot.spotIndex];
                      return LineTooltipItem(
                        'Total Mark: ${flSpot.y}\nReview Name: ${weekData.reviewName}',
                       const  TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

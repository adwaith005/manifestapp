import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(widget.uid)
            .collection('weeks')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> weeks = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: true),
                barGroups: List.generate(
                  weeks.length,
                  (index) {
                    var week = weeks[index].data() as Map<String, dynamic>;

                    if (week.containsKey('totalMark')) {
                      var totalMarkString = week['totalMark'] ?? "0";

                      // Check if the value is a valid double
                      if (totalMarkString is String &&
                          double.tryParse(totalMarkString) != null) {
                        var totalMark = double.parse(totalMarkString);

                        // Determine the section based on the week index
                        String section;
                        if (index >= 0 && index <= 9) {
                          section = 'Week 1-10';
                        } else if (index >= 10 && index <= 19) {
                          section = 'Week 11-20';
                        } else {
                          section = 'Other Weeks';
                        }
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: totalMark, // Set the toY property
                              color: Colors.blue,
                              width: 20,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        );
                      } else {
                        // Handle the case where 'totalMark' is not a valid double
                        return BarChartGroupData(x: index, barRods: []);
                      }
                    } else {
                      // Handle the case where 'totalMark' is not present
                      return BarChartGroupData(x: index, barRods: []);
                    }
                  },
                ),
                groupsSpace:
                    20.0, // Adjust this value for the space between groups
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueAccent,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY!.round().toString(),
                        TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
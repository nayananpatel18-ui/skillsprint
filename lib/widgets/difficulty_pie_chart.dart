import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DifficultyPieChart extends StatelessWidget {
  final int beginner;
  final int intermediate;
  final int advanced;

  const DifficultyPieChart({
    super.key,
    required this.beginner,
    required this.intermediate,
    required this.advanced,
  });

  @override
  Widget build(BuildContext context) {
    final total = beginner + intermediate + advanced;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Difficulty Distribution",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 240,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 60,

                  sections: [

                    PieChartSectionData(
                      value: beginner.toDouble(),
                      color: Colors.green,
                      radius: 70,
                      title: total == 0
                          ? "0%"
                          : "${((beginner / total) * 100).round()}%",
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      value: intermediate.toDouble(),
                      color: Colors.orange,
                      radius: 70,
                      title: total == 0
                          ? "0%"
                          : "${((intermediate / total) * 100).round()}%",
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      value: advanced.toDouble(),
                      color: Colors.red,
                      radius: 70,
                      title: total == 0
                          ? "0%"
                          : "${((advanced / total) * 100).round()}%",
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 18,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: const [

                _LegendItem(
                  color: Colors.green,
                  text: "Beginner",
                ),

                _LegendItem(
                  color: Colors.orange,
                  text: "Intermediate",
                ),

                _LegendItem(
                  color: Colors.red,
                  text: "Advanced",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),

        const SizedBox(width: 6),

        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

      ],
    );
  }
}
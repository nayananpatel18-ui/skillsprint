import 'package:flutter/material.dart';
import 'stat_card.dart';

class OverviewCards extends StatelessWidget {
  final int total;
  final int completed;
  final double average;

  const OverviewCards({
    super.key,
    required this.total,
    required this.completed,
    required this.average,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          crossAxisCount: isMobile ? 2 : 4,

          crossAxisSpacing: 15,

          mainAxisSpacing: 15,

          childAspectRatio: isMobile ? 1.2 : 1.6,

          children: [
            StatCard(
              icon: Icons.menu_book_rounded,
              color: Colors.blue,
              title: "Total Skills",
              value: total.toString(),
            ),

            StatCard(
              icon: Icons.check_circle,
              color: Colors.green,
              title: "Completed",
              value: completed.toString(),
            ),

            StatCard(
              icon: Icons.local_fire_department,
              color: Colors.orange,
              title: "In Progress",
              value: (total - completed).toString(),
            ),

            StatCard(
              icon: Icons.trending_up,
              color: Colors.indigo,
              title: "Average",
              value: "${average.toStringAsFixed(0)}%",
            ),
          ],
        );
      },
    );
  }
}
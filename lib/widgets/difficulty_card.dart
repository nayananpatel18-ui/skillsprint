import 'package:flutter/material.dart';

class DifficultyCard extends StatelessWidget {
  final int beginner;
  final int intermediate;
  final int advanced;

  const DifficultyCard({
    super.key,
    required this.beginner,
    required this.intermediate,
    required this.advanced,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Difficulty Distribution",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildTile(
              "Beginner",
              beginner,
              Colors.green,
              Icons.emoji_events_outlined,
            ),

            const Divider(),

            _buildTile(
              "Intermediate",
              intermediate,
              Colors.orange,
              Icons.trending_up,
            ),

            const Divider(),

            _buildTile(
              "Advanced",
              advanced,
              Colors.red,
              Icons.workspace_premium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    String title,
    int value,
    Color color,
    IconData icon,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: CircleAvatar(
        radius: 22,
        backgroundColor: color.withOpacity(.15),
        child: Icon(
          icon,
          color: color,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      trailing: Text(
        value.toString(),
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

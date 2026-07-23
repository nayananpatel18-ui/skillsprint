import 'package:flutter/material.dart';

class LatestSkillCard extends StatelessWidget {
  final String latestSkill;

  const LatestSkillCard({
    super.key,
    required this.latestSkill,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),

        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue.withOpacity(.15),
          child: const Icon(
            Icons.history_edu_rounded,
            color: Colors.blue,
          ),
        ),

        title: const Text(
          "Recently Added Skill",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        
        subtitle: Text(
          latestSkill,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.grey,
        ),
      ),
    );
  }
}
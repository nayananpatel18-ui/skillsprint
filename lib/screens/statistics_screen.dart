import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/motivation_card.dart';
import '../widgets/progress_ring.dart';
import '../widgets/difficulty_card.dart';
import '../widgets/difficulty_pie_chart.dart';
import '../widgets/latest_skill_card.dart';
import '../widgets/overview_cards.dart';

import '../widgets/stat_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
Widget build(BuildContext context) {

  final uid = FirebaseAuth.instance.currentUser!.uid;

  return Scaffold(

    appBar: AppBar(
      title: const Text("Statistics"),
    ),

    body: StreamBuilder<QuerySnapshot>(

      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("skills")
          .snapshots(),

      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return buildStatistics(
          snapshot.data!.docs,
        );

      },

    ),

  );
}
  
Widget buildStatistics(List<QueryDocumentSnapshot> docs) {

  int total = docs.length;

  int completed = 0;

  int beginner = 0;
  int intermediate = 0;
  int advanced = 0;

  double average = 0;

  double totalProgress = 0;

  String latestSkill = "No Skill";

  if (docs.isNotEmpty) {
    latestSkill = docs.first["skillName"];
  }

  for (var doc in docs) {

    final data = doc.data() as Map<String, dynamic>;

    totalProgress += data["progress"];

    if (data["completed"] == true) {
      completed++;
    }

    switch (data["difficulty"]) {

      case "Beginner":
        beginner++;
        break;

      case "Intermediate":
        intermediate++;
        break;

      case "Advanced":
        advanced++;
        break;
    }
  }

  if (total != 0) {
    average = totalProgress / total;
  }

  return ListView(

    padding: const EdgeInsets.all(16),

    children: [

      OverviewCards(
  total: total,
  completed: completed,
  average: average,
),

      const SizedBox(height: 25),

      ProgressRing(
  average: average,
),

      const SizedBox(height: 25),

      DifficultyCard(
  beginner: beginner,
  intermediate: intermediate,
  advanced: advanced,
),

const SizedBox(height: 25),

DifficultyPieChart(
  beginner: beginner,
  intermediate: intermediate,
  advanced: advanced,
),


      const SizedBox(height: 25),

      LatestSkillCard(
  latestSkill: latestSkill,
),

      const SizedBox(height: 25),

      const MotivationCard(),

    ],
  );
}
 


  Widget buildCard(String title, String value) {

    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: ListTile(
        title: Text(title),

        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

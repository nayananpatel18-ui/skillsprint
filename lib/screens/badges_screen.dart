import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/badge_card.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
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

          final docs = snapshot.data!.docs;

          int totalSkills = docs.length;
          int completedSkills = 0;

          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;

            if (data["completed"] == true) {
              completedSkills++;
            }
          }

          final badges = [

            BadgeCard(
              icon: Icons.star,
              title: "First Skill",
              unlocked: totalSkills >= 1,
              color: Colors.orange,
            ),

            BadgeCard(
              icon: Icons.workspace_premium,
              title: "5 Skills",
              unlocked: totalSkills >= 5,
              color: Colors.blue,
            ),

            BadgeCard(
              icon: Icons.emoji_events,
              title: "10 Skills",
              unlocked: totalSkills >= 10,
              color: Colors.purple,
            ),

            BadgeCard(
              icon: Icons.school,
              title: "Skill Master",
              unlocked: completedSkills >= 5,
              color: Colors.green,
            ),

            BadgeCard(
              icon: Icons.local_fire_department,
              title: "Learning Legend",
              unlocked: completedSkills >= 10,
              color: Colors.red,
            ),

            BadgeCard(
              icon: Icons.military_tech,
              title: "Champion",
              unlocked: totalSkills != 0 &&
                  completedSkills == totalSkills,
              color: Colors.amber,
            ),

          ];

          return Padding(
            padding: const EdgeInsets.all(20),

            child: GridView.builder(

              itemCount: badges.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 15,

                mainAxisSpacing: 15,

                childAspectRatio: 1.15,

              ),

              itemBuilder: (context, index) {

                return badges[index];

              },

            ),

          );

        },

      ),

    );

  }

}
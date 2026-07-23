import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/progress_ring.dart';


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

    padding: const EdgeInsets.all(20),

    children: [

      buildOverviewCards(
        total,
        completed,
        average,
      ),

      const SizedBox(height: 25),

      ProgressRing(
  average: average,
),

      const SizedBox(height: 25),

      buildDifficultyCard(
  beginner,
  intermediate,
  advanced,
),

const SizedBox(height: 25),

buildPieChart(
  beginner,
  intermediate,
  advanced,
),


      const SizedBox(height: 25),

      buildLatestSkill(latestSkill),

      const SizedBox(height: 25),

      buildMotivationCard(),

    ],
  );
}
 
 
Widget buildOverviewCards(
  int total,
  int completed,
  double average,
) {
 return LayoutBuilder(
  builder: (context, constraints) {
    final isMobile = constraints.maxWidth < 600;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 2 : 4,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: isMobile ? 1.1 : 1.4,
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

Widget buildDifficultyCard(
    int beginner,
    int intermediate,
    int advanced,
) {

  return Card(

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

          const SizedBox(height: 15),

          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
            ),
            title: const Text("Beginner"),
            trailing: Text(beginner.toString()),
          ),

          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
            ),
            title: const Text("Intermediate"),
            trailing: Text(intermediate.toString()),
          ),

          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
            ),
            title: const Text("Advanced"),
            trailing: Text(advanced.toString()),
          ),
        ],
      ),
    ),
  );
}

Widget buildPieChart(

    int beginner,
    int intermediate,
    int advanced,

) {

  return Card(

    child: Padding(

      padding: const EdgeInsets.all(20),

      child: Column(

        children: [

          const Text(

            "Difficulty Chart",

            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),

          ),

          const SizedBox(height: 20),

          SizedBox(

            height: 220,

            child: PieChart(

              PieChartData(

                sectionsSpace: 4,

                centerSpaceRadius: 45,

                sections: [

                  PieChartSectionData(

                    value: beginner.toDouble(),

                    color: Colors.green,

                    title: beginner.toString(),

                    radius: 65,

                  ),

                  PieChartSectionData(

                    value: intermediate.toDouble(),

                    color: Colors.orange,

                    title: intermediate.toString(),

                    radius: 65,

                  ),

                  PieChartSectionData(

                    value: advanced.toDouble(),

                    color: Colors.red,

                    title: advanced.toString(),

                    radius: 65,

                  ),

                ],

              ),

            ),

          ),

          const SizedBox(height: 20),

          const Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

              Row(

                children: [

                  CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.green,
                  ),

                  SizedBox(width: 5),

                  Text("Beginner"),

                ],

              ),

              Row(

                children: [

                  CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.orange,
                  ),

                  SizedBox(width: 5),

                  Text("Intermediate"),

                ],

              ),

              Row(

                children: [

                  CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                  ),

                  SizedBox(width: 5),

                  Text("Advanced"),

                ],

              ),

            ],

          ),

        ],

      ),

    ),

  );

}

Widget buildLatestSkill(String latestSkill) {

  return Card(

    child: ListTile(

      leading: const Icon(
        Icons.history,
        color: Colors.blue,
      ),

      title: const Text(
        "Most Recent Skill",
      ),

      subtitle: Text(latestSkill),
    ),
  );
}

Widget buildMotivationCard() {

  return Card(

    child: Padding(

      padding: const EdgeInsets.all(20),

      child: Column(

        children: const [

          Text(
            "Keep Going! 🚀",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Every skill you learn today builds your future.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
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

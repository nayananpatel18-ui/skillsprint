import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/skill.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'statistics_screen.dart';
import 'badges_screen.dart';
import '../widgets/streak_card.dart';

import '../widgets/skill_card.dart';
import 'add_skill_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  

  Future<void> addSkill() async {

  await Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => const AddSkillScreen(),

    ),

  );

}

Future<void> deleteSkill(String docId) async {

  bool? confirm = await showDialog(

    context: context,

    builder: (context){

      return AlertDialog(

        title: const Text("Delete Skill"),

        content: const Text(

          "Are you sure you want to delete this skill?",

        ),

        actions: [

          TextButton(

            onPressed: (){

              Navigator.pop(context,false);

            },

            child: const Text("Cancel"),

          ),

          ElevatedButton(

            onPressed: (){

              Navigator.pop(context,true);

            },

            child: const Text("Delete"),

          ),

        ],

      );

    },

  );

  if(confirm != true) return;

  await FirebaseFirestore.instance

      .collection("users")

      .doc(FirebaseAuth.instance.currentUser!.uid)

      .collection("skills")

      .doc(docId)

      .delete();

}
Future<void> logout() async {

  bool? confirm = await showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        title: const Text("Logout"),

        content: const Text(
          "Are you sure you want to logout?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context, false);

            },

            child: const Text("Cancel"),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(context, true);

            },

            child: const Text("Logout"),

          ),

        ],

      );

    },

  );

  if (confirm != true) return;

  await FirebaseAuth.instance.signOut();

  if (!mounted) return;

  Navigator.pushAndRemoveUntil(

    context,

    MaterialPageRoute(

      builder: (_) => const LoginScreen(),

    ),

    (route) => false,

  );

}

Future<void> editSkill(
    String docId,
    Map<String, dynamic> data,
) async {

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => AddSkillScreen(

        documentId: docId,

        existingData: data,

      ),

    ),

  );

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("SkillSprint"),

        centerTitle: true,

      ),

      drawer: Drawer(

        child: ListView(

          children: [

            const DrawerHeader(

              decoration: BoxDecoration(

                color: Colors.indigo,

              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  CircleAvatar(

                    radius: 30,

                    child: Icon(

                      Icons.person,

                      size: 30,

                    ),

                  ),

                  SizedBox(height: 10),

                  Text(

                    "Welcome!",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 22,

                    ),

                  ),

                ],

              ),

            ),

            ListTile(

              leading: const Icon(Icons.home),

              title: const Text("Home"),

              onTap: () {

                Navigator.pop(context);

              },

            ),

            ListTile(

  leading: const Icon(Icons.person),

  title: const Text("Profile"),

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const ProfileScreen(),

      ),

    );

  },

),

            ListTile(

              leading: const Icon(Icons.bar_chart),

              title: const Text("Statistics"),

              onTap: () {

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => const StatisticsScreen(),

    ),

  );

},

            ),

            ListTile(
  leading: const Icon(
    Icons.workspace_premium,
    color: Colors.amber,
  ),

  title: const Text("Achievements"),

  onTap: () {

    Navigator.pop(context);

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const BadgesScreen(),

      ),

    );

  },

),

            ListTile(

              leading: const Icon(Icons.logout),

              title: const Text("Logout"),

              onTap: logout,

            ),

          ],

        ),

      ),

      floatingActionButton: FloatingActionButton(

        onPressed: addSkill,

        child: const Icon(Icons.add),

      ),

      body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
Container(

  width: double.infinity,

  padding: const EdgeInsets.all(22),

  decoration: BoxDecoration(

    gradient: const LinearGradient(

      colors: [

        Colors.indigo,

        Colors.deepPurple,

      ],

      begin: Alignment.topLeft,

      end: Alignment.bottomRight,

    ),

    borderRadius: BorderRadius.circular(25),

  ),

  child: Column(

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      const Text(

        "👋 Good Evening",

        style: TextStyle(

          color: Colors.white,

          fontSize: 28,

          fontWeight: FontWeight.bold,

        ),

      ),

      const SizedBox(height: 12),

      const Text(

        "Keep learning. Keep growing every single day.",

        style: TextStyle(

          color: Colors.white70,

          fontSize: 18,

        ),

      ),

      const SizedBox(height: 10),

const StreakCard(
  streak: 7,
),

const SizedBox(height: 10),

      LinearProgressIndicator(

        value: 0.8,

        minHeight: 10,

        borderRadius: BorderRadius.circular(20),

        backgroundColor: Colors.white24,

        color: Colors.white,

      ),

      const SizedBox(height: 14),

      const Text(

        "Your journey has just begun 🚀",

        style: TextStyle(

          color: Colors.white,

          fontWeight: FontWeight.w500,

        ),

      ),

    ],

  ),

),

const SizedBox(height: 20),

            Card(

              elevation: 4,

              child: Padding(

                padding: const EdgeInsets.all(14),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [

                    Text(

                      "💡 Quote of the Day",

                      style: TextStyle(

                        fontSize: 18,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                    SizedBox(height: 10),

                    Text(

                      "\"The expert in anything was once a beginner.\"",

                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(height: 25),

            const Text(

              "📚 Your Skills",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 15),

StreamBuilder<QuerySnapshot>(

    stream: FirebaseFirestore.instance

        .collection("users")

        .doc(FirebaseAuth.instance.currentUser!.uid)

        .collection("skills")

        .orderBy("createdDate", descending: true)

        .snapshots(),

    builder: (context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {

        return const Center(

          child: CircularProgressIndicator(),

        );

      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {

        return Card(

          child: Center(

            child: Padding(

              padding: const EdgeInsets.all(30),

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: const [

                  Icon(

                    Icons.school,

                    size: 70,

                    color: Colors.grey,

                  ),

                  SizedBox(height: 20),

                  Text(

                    "No Skills Added Yet",

                    style: TextStyle(

                      fontSize: 22,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  SizedBox(height: 10),

                  Text(

                    "Press + to add your first skill.",

                    textAlign: TextAlign.center,

                  ),

                ],

              ),

            ),

          ),

        );

      }

      final docs = snapshot.data!.docs;

      return ListView.builder(
        
        shrinkWrap: true,

  physics:
      const NeverScrollableScrollPhysics(),
        itemCount: docs.length,

        itemBuilder: (context, index) {

          final data = docs[index];

final skill = Skill(

  id: docs[index].id,

  skillName: data["skillName"],

  category: data["category"],

  difficulty: data["difficulty"],

  progress: data["progress"],

  description: data["description"],

  createdDate:
      (data["createdDate"] as Timestamp).toDate(),

  lastUpdated:
      (data["lastUpdated"] as Timestamp).toDate(),

  resources:
      List<String>.from(
        data["resources"],
      ),

  resourcesCompleted:
      List<bool>.from(
        data["resourcesCompleted"],
      ),

  completed: data["completed"],

);

return SkillCard(
  skill: skill,

  onEdit: () {
  editSkill(
    docs[index].id,
    data.data() as Map<String, dynamic>,
  );
},

onDelete: () {
  deleteSkill(docs[index].id);
},
);
        },

      );

    },

  ),

          ]
          

        ),

  )

      )
    );
  }
}
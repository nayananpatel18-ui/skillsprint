import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .collection("skills")
            .snapshots(),

        builder: (context, snapshot) {

          int totalSkills = 0;
          int completedSkills = 0;

          if(snapshot.hasData){

            totalSkills = snapshot.data!.docs.length;

            for(var doc in snapshot.data!.docs){

              if(doc["completed"] == true){

                completedSkills++;

              }

            }

          }

          return SingleChildScrollView(

            padding: const EdgeInsets.all(20),

            child: Column(

              children: [

                const SizedBox(height:20),

                const CircleAvatar(

                  radius:55,

                  child: Icon(
                    Icons.person,
                    size:60,
                  ),

                ),

                const SizedBox(height:20),

                Text(

                  user.displayName ?? "SkillSprint User",

                  style: const TextStyle(

                    fontSize:26,
                    fontWeight: FontWeight.bold,

                  ),

                ),

                const SizedBox(height:10),

                Text(

                  user.email ?? "",

                  style: const TextStyle(

                    fontSize:16,
                    color: Colors.grey,

                  ),

                ),

                const SizedBox(height:30),

                Card(

                  child: ListTile(

                    leading: const Icon(Icons.school),

                    title: const Text("Total Skills"),

                    trailing: Text(

                      "$totalSkills",

                      style: const TextStyle(

                        fontWeight: FontWeight.bold,

                        fontSize:20,

                      ),

                    ),

                  ),

                ),

                Card(

                  child: ListTile(

                    leading: const Icon(Icons.check_circle,color: Colors.green),

                    title: const Text("Completed Skills"),

                    trailing: Text(

                      "$completedSkills",

                      style: const TextStyle(

                        fontWeight: FontWeight.bold,

                        fontSize:20,

                      ),

                    ),

                  ),

                ),

                Card(

                  child: ListTile(

                    leading: const Icon(Icons.pending_actions,color: Colors.orange),

                    title: const Text("In Progress"),

                    trailing: Text(

                      "${totalSkills-completedSkills}",

                      style: const TextStyle(

                        fontWeight: FontWeight.bold,

                        fontSize:20,

                      ),

                    ),

                  ),

                ),

                Card(

                  child: ListTile(

                    leading: const Icon(Icons.calendar_today),

                    title: const Text("Member Since"),

                    trailing: Text(

                      "${user.metadata.creationTime?.day}/${user.metadata.creationTime?.month}/${user.metadata.creationTime?.year}",

                    ),

                  ),

                ),

              ],

            ),

          );

        },

      ),

    );

  }

}
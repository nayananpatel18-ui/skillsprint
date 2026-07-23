import 'package:flutter/material.dart';
import '../models/skill.dart';

class SkillCard extends StatelessWidget {
  final Skill skill;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SkillCard({
    super.key,
    required this.skill,
    required this.onEdit,
    required this.onDelete,
  });

  Color getDifficultyColor() {
    switch (skill.difficulty) {
      case "Beginner":
        return Colors.green;

      case "Intermediate":
        return Colors.orange;

      case "Advanced":
        return Colors.red;

      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //----------------------
            // Top Row
            //----------------------

            Row(
              children: [

                Container(
  width: 55,
  height: 55,
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        Color(0xff5B86E5),
        Color(0xff36D1DC),
      ],
    ),
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(0.35),
        blurRadius: 12,
        offset: const Offset(0, 5),
      ),
    ],
  ),
  child: Center(
    child: Text(
      skill.skillName[0].toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        skill.skillName,
                        style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
),
                      ),

                      Text(
                         "📂 ${skill.category}",
                          style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          ),
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                 onSelected: (value) {

  if (value == "edit") {
    onEdit();
  }

  if (value == "delete") {
    onDelete();
  }

},

                  itemBuilder: (context) => [

                    const PopupMenuItem(
                      value: "edit",
                      child: Text("Edit"),
                    ),

                    const PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 15),

            //----------------------
            // Difficulty Chip
            //----------------------

            Chip(
              label: Text(skill.difficulty),
              
              

              backgroundColor:
                  getDifficultyColor()
                      .withOpacity(0.15),
            ),

            const SizedBox(height: 15),

            //----------------------
            // Progress
            //----------------------

            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

    const Text(
      "Learning Progress",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),

    Text(
      "${skill.progress}%",
      style: TextStyle(
        color: getDifficultyColor(),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),

  ],
),

            const SizedBox(height: 8),

            ClipRRect(
  borderRadius: BorderRadius.circular(15),
  child: LinearProgressIndicator(
    value: skill.progress / 100,
    minHeight: 12,
    backgroundColor: Colors.grey.shade300,
    valueColor: AlwaysStoppedAnimation(
      getDifficultyColor(),
    ),
  ),
),

            const SizedBox(height: 15),

            //----------------------
            // Description
            //----------------------

           const Row(
  children: [

    Icon(
      Icons.menu_book,
      color: Colors.indigo,
    ),

    SizedBox(width: 8),

    Text(
      "Learning Resources",
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),

  ],
),

const SizedBox(height: 10),

Column(

  children: List.generate(

    skill.resources.length,

    (index) {

      return Row(

        children: [

          Icon(

            skill.resourcesCompleted[index]
                ? Icons.check_circle
                : Icons.radio_button_unchecked,

            color: skill.resourcesCompleted[index]
                ? Colors.green
                : Colors.grey,

            size: 20,

          ),

          const SizedBox(width: 10),

          Expanded(

            child: Text(

              skill.resources[index],

            ),

          ),

        ],

      );

    },

  ),

),

const SizedBox(height: 15),

Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(
    skill.description.isEmpty
        ? "No description added."
        : skill.description,
    style: TextStyle(
      color: Colors.grey.shade700,
      height: 1.4,
    ),
  ),
),

const SizedBox(height: 15),
            //----------------------
            // Date
            //----------------------

           Row(
  children: [

    const Icon(
      Icons.calendar_today,
      size: 16,
      color: Colors.grey,
    ),

    const SizedBox(width: 6),

    Text(
      "Added: ${skill.createdDate.day}/${skill.createdDate.month}/${skill.createdDate.year}",
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 12,
      ),
    ),

  ],
),
          ],
        ),
      ),
    );
  }
}
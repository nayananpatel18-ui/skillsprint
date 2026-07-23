import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSkillScreen extends StatefulWidget {

  final String? documentId;
  final Map<String, dynamic>? existingData;

  const AddSkillScreen({
    super.key,
    this.documentId,
    this.existingData,
  });

  @override
  State<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {

  final _formKey = GlobalKey<FormState>();

  final skillController = TextEditingController();
  final descriptionController = TextEditingController();

  String selectedCategory = "Programming";
  String selectedDifficulty = "Beginner";

  final List<String> categories = [
    "Programming",
    "AI & Data Science",
    "Mobile Development",
    "Web Development",
    "Cloud",
    "Database",
    "DevOps",
    "Design",
    "Language",
    "Business",
    "Others",
  ];

  final List<String> difficultyLevels = [
    "Beginner",
    "Intermediate",
    "Advanced",
  ];

  @override
void initState() {
  super.initState();
if (widget.existingData != null) {

  skillController.text =
      widget.existingData!["skillName"];

  descriptionController.text =
      widget.existingData!["description"];

  selectedCategory =
      widget.existingData!["category"];

  selectedDifficulty =
      widget.existingData!["difficulty"];

  resources =
      List<String>.from(
        widget.existingData!["resources"],
      );

  completedResources =
      List<bool>.from(
        widget.existingData!["resourcesCompleted"],
      );
  progress = widget.existingData!["progress"] ?? 0;

  isCompleted =
    widget.existingData!["completed"] ?? false;
}
}

  bool loading = false;
  final List<String> defaultResources = [

  "Course",

  "Official Docs",

  "YouTube Playlist",

  "Portfolio Project",

  "Mini Quiz / Notes",

];

final customController = TextEditingController();

List<String> resources = [
  "Course",
  "Official Docs",
  "YouTube Playlist",
  "Portfolio Project",
  "Mini Quiz / Notes",
];

List<bool> completedResources = [
  false,
  false,
  false,
  false,
  false,
];

int progress = 0;

bool isCompleted = false;

  Future<void> saveSkill() async {

  if (!_formKey.currentState!.validate()) return;

  setState(() {
    loading = true;
  });

  try {

    User user = FirebaseAuth.instance.currentUser!;

    final data = {

  "skillName": skillController.text.trim(),
  "category": selectedCategory,
  "difficulty": selectedDifficulty,
  "description": descriptionController.text.trim(),

  "progress": progress,

  "completed": isCompleted,

  "createdDate":
      widget.existingData?["createdDate"] ??
      Timestamp.now(),

  "lastUpdated": Timestamp.now(),

  "resources": resources,

  "resourcesCompleted": completedResources,
};

    if (widget.documentId == null) {

      await FirebaseFirestore.instance

          .collection("users")

          .doc(user.uid)

          .collection("skills")

          .add(data);

    } else {

      await FirebaseFirestore.instance

          .collection("users")

          .doc(user.uid)

          .collection("skills")

          .doc(widget.documentId)

          .update(data);

    }

    if (!mounted) return;

    Navigator.pop(context);

  } catch (e) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(e.toString()),
      ),

    );

  }

  if (mounted) {

    setState(() {

      loading = false;

    });

  }

}
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(
  widget.documentId == null
      ? "Add Skill"
      : "Edit Skill",
),

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              TextFormField(

                controller: skillController,

                decoration: const InputDecoration(

                  labelText: "Skill Name",

                  border: OutlineInputBorder(),

                ),

                validator: (value){

                  if(value==null || value.trim().isEmpty){

                    return "Enter skill";

                  }

                  return null;

                },

              ),

              const SizedBox(height:20),

              DropdownButtonFormField(

                initialValue: selectedCategory,

                decoration: const InputDecoration(

                  labelText: "Category",

                  border: OutlineInputBorder(),

                ),

                items: categories.map((e){

                  return DropdownMenuItem(

                    value: e,

                    child: Text(e),

                  );

                }).toList(),

                onChanged: (value){

                  setState(() {

                    selectedCategory=value!;

                  });

                },

              ),

              const SizedBox(height:20),

              DropdownButtonFormField(

                value: selectedDifficulty,

                decoration: const InputDecoration(

                  labelText: "Difficulty",

                  border: OutlineInputBorder(),

                ),

                items: difficultyLevels.map((e){

                  return DropdownMenuItem(

                    value: e,

                    child: Text(e),

                  );

                }).toList(),

                onChanged: (value){

                  setState(() {

                    selectedDifficulty=value!;

                  });

                },

              ),

              const SizedBox(height:20),

              TextFormField(

                controller: descriptionController,

                maxLines:4,

                decoration: const InputDecoration(

                  labelText: "Description",

                  border: OutlineInputBorder(),

                ),

              ),

              const SizedBox(height: 25),

const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Resources",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 10),

ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: resources.length,
  itemBuilder: (context, index) {
    return Card(
      child: CheckboxListTile(
        value: completedResources[index],

        title: Text(resources[index]),

        onChanged: (value) {
          setState(() {
            completedResources[index] = value!;

            int completed =
                completedResources.where((e) => e).length;

            int total = completedResources.length;

            // Update progress automatically
            progress =
                ((completed / total) * 100).round();

            isCompleted = completed == total;
          });
        },

        secondary: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),

          onPressed: () {

  if (resources.length == 1) {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "At least one resource is required.",
        ),

      ),

    );

    return;
  }

  setState(() {

    resources.removeAt(index);
              completedResources.removeAt(index);

              int completed =
                  completedResources.where((e) => e).length;

              int total = completedResources.length;

              progress = total == 0
                  ? 0
                  : ((completed / total) * 100).round();

              isCompleted =
                  total != 0 &&
                  completed == total;

            });

          },
        ),
      ),
    );
  },
),

const SizedBox(height: 20),

Row(
  children: [

    Expanded(

      child: TextField(

        controller: customController,

        decoration: const InputDecoration(

          labelText: "Add Custom Resource",

          border: OutlineInputBorder(),

        ),

      ),

    ),

    const SizedBox(width: 10),

    ElevatedButton(

      onPressed: () {

        if (customController.text.trim().isEmpty) return;

        setState(() {

          resources.add(
            customController.text.trim(),
          );

          completedResources.add(false);

          customController.clear();

        });

      },

      child: const Icon(Icons.add),

    ),

  ],
),

const SizedBox(height: 30),


              SizedBox(

                width: double.infinity,

                height:55,

                child: ElevatedButton(

                  onPressed: loading ? null : saveSkill,

                  child: loading

                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(

  widget.documentId == null
      ? "SAVE SKILL"
      : "UPDATE SKILL",

  style: const TextStyle(
    fontSize: 18,
  ),

)

                ),

              )

            ],

          ),

        ),

      ),

    );

  }
@override
void dispose() {

  skillController.dispose();

  descriptionController.dispose();

  customController.dispose();

  super.dispose();

}
}
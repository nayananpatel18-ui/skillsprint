import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {

  final int streak;

  const StreakCard({
    super.key,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 8,

      shadowColor: Colors.orange.withOpacity(0.4),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      child: Container(

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10),

          gradient: const LinearGradient(

            colors: [

              Color(0xffFF9800),

              Color(0xffFF5722),

            ],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

          ),

        ),

        padding: const EdgeInsets.all(10),

        child: Row(

          children: [

            const Icon(

              Icons.local_fire_department,

              color: Colors.white,

              size: 21,

            ),

            const SizedBox(width: 8),

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Daily Learning Streak",

                    style: TextStyle(

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                      fontSize: 20,

                    ),

                  ),

                  const SizedBox(height: 2),

                  Text(

                    "$streak Days",

                    style: const TextStyle(

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                      fontSize: 16,

                    ),

                  ),

                  const SizedBox(height: 2),

                  const Text(

                    "Keep learning every day! 🚀",

                    style: TextStyle(

                      color: Colors.white70,
                       fontSize: 18,

                    ),

                  ),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }

}
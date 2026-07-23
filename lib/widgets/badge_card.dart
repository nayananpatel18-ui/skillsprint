import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final bool unlocked;
  final Color color;

  const BadgeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.unlocked,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(

      duration: const Duration(milliseconds: 400),

      padding: const EdgeInsets.symmetric(
  horizontal: 10,
  vertical: 10,
),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(18),

        color: unlocked
            ? color.withOpacity(.15)
            : Colors.grey.shade200,

        boxShadow: [

          if (unlocked)

            BoxShadow(
              color: color.withOpacity(.3),
              blurRadius: 12,
            )

        ],

      ),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Icon(

            icon,

            color: unlocked
                ? color
                : Colors.grey,

            size: 32,

          ),

          const SizedBox(height: 6),

          Text(
  title,
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: unlocked
        ? Colors.black
        : Colors.grey,
  ),
),

          const SizedBox(height: 4),

          Text(
  unlocked ? "Unlocked" : "Locked",
  style: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: unlocked
        ? Colors.green
        : Colors.grey,
  ),
),

        ],

      ),

    );

  }

}
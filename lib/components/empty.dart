import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final DateTime date;
  final String formattedDate;

  const EmptyCard({super.key, required this.date, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          const Icon(Icons.fitness_center, color: Colors.white24, size: 22),
          const SizedBox(width: 12),
          Text(
            'No workout scheduled for $formattedDate',
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
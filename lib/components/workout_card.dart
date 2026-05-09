import 'package:flutter/material.dart';

import '../models/workout_card.dart';

class WorkoutCardWidget extends StatelessWidget {
  final WorkoutCard card;
  final bool isFloating;

  const WorkoutCardWidget({super.key, required this.card, this.isFloating = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.hardEdge,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF18181C),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isFloating
                      ? [BoxShadow(color: Colors.black45, blurRadius: 16, offset: const Offset(0, 6))]
                      : null,
                  border: isFloating
                      ? Border.all(color: Colors.white12)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.drag_indicator, color: Colors.white24, size: 14),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: card.categoryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: card.categoryColor.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(card.categoryIcon, color: card.categoryColor, size: 10),
                              const SizedBox(width: 4),
                              Text(
                                card.category,
                                style: TextStyle(
                                  color: card.categoryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${card.minDuration}m - ${card.maxDuration}m',
                          style: const TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
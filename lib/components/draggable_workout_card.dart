import 'package:flutter/material.dart';
import 'package:hero_app/components/workout_card.dart';

import '../models/workout_card.dart';

class DraggableWorkoutCard extends StatelessWidget {
  final WorkoutCard card;
  final DateTime fromDate;
  final VoidCallback onDirty;

  const DraggableWorkoutCard({super.key,
    required this.card,
    required this.fromDate,
    required this.onDirty,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = WorkoutCardWidget(card: card);

    return Draggable<Map<String, dynamic>>(
      data: {'card': card, 'fromDate': fromDate},
      onDragStarted: onDirty,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.9,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child: WorkoutCardWidget(card: card, isFloating: true),
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: cardWidget),
      child: cardWidget,
    );
  }
}
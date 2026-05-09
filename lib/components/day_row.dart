import 'package:flutter/material.dart';

import '../models/day_slot.dart';
import '../models/workout_card.dart';
import 'draggable_workout_card.dart';

class DayRow extends StatefulWidget {
  final DaySlot day;
  final List<DaySlot> allDays;
  final void Function(WorkoutCard, DateTime, DateTime) onCardMoved;
  final VoidCallback onDirty;

  const DayRow({super.key,
    required this.day,
    required this.allDays,
    required this.onCardMoved,
    required this.onDirty,
  });

  @override
  State<DayRow> createState() => DayRowState();
}

class DayRowState extends State<DayRow> {
  bool _isDragOver = false;

  static const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  String get _dayName => _dayNames[widget.day.date.weekday - 1];

  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) {
        final fromDate = details.data['fromDate'] as DateTime;
        final sameDay = fromDate.year == widget.day.date.year &&
            fromDate.month == widget.day.date.month &&
            fromDate.day == widget.day.date.day;
        return !sameDay;
      },
      onAcceptWithDetails: (details) {
        setState(() => _isDragOver = false);
        final card = details.data['card'] as WorkoutCard;
        final fromDate = details.data['fromDate'] as DateTime;
        widget.onCardMoved(card, fromDate, widget.day.date);
      },
      onMove: (_) => setState(() => _isDragOver = true),
      onLeave: (_) => setState(() => _isDragOver = false),
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: _isDragOver
                ? Colors.green.withValues(alpha: 0.08)
                : Colors.transparent,
            border: _isDragOver
                ? Border(left: BorderSide(color: Colors.green, width: 2))
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 44,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_dayName,
                        style: const TextStyle(color: Colors.white38, fontSize: 14, fontWeight: .w700)),
                    Text(
                      '${widget.day.date.day}',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: widget.day.cards.isEmpty
                    ? Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  child: _isDragOver
                      ? const Text('Drop here',
                      style: TextStyle(
                          color: Colors.green, fontSize: 13))
                      : Container(
                    height: 1,
                    color: Colors.white10,
                    margin: const EdgeInsets.only(top: 24),
                  ),
                )
                    : Column(
                  children: widget.day.cards
                      .map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: DraggableWorkoutCard(
                      card: card,
                      fromDate: widget.day.date,
                      onDirty: widget.onDirty,
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
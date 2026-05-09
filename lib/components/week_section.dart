import 'package:flutter/material.dart';

import '../models/day_slot.dart';
import '../models/workout_card.dart';
import 'day_row.dart';

class WeekSection extends StatelessWidget {
  final int weekNumber;
  final int totalWeeks;
  final String dateRange;
  final int totalMinutes;
  final List<DaySlot> days;
  final void Function(WorkoutCard, DateTime, DateTime) onCardMoved;
  final VoidCallback onDirty;

  const WeekSection({super.key,
    required this.weekNumber,
    required this.totalWeeks,
    required this.dateRange,
    required this.totalMinutes,
    required this.days,
    required this.onCardMoved,
    required this.onDirty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: switch (weekNumber) {
                    1 => Colors.green,
                    2 => Colors.blue,
                    3 => Colors.yellow,
                    4 => Colors.purple,
                    5 => Colors.red,
                    int() => Colors.white,
                  },
                  width: 4
              )
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Week $weekNumber/$totalWeeks',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                ),
                if (totalMinutes > 0)
                  Text(
                    'Total: ${totalMinutes}min',
                    style: const TextStyle(color: Color(0xFF7A7C90), fontWeight: .w400, fontSize: 16),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(dateRange,
                style: const TextStyle(color: Color(0xFF7A7C90), fontSize: 16, fontWeight: .w400)),
          ),
          ...days.map((day) => DayRow(
            day: day,
            allDays: days,
            onCardMoved: onCardMoved,
            onDirty: onDirty,
          )),
          Container(height: 1, color: Colors.white10, margin: const EdgeInsets.only(top: 8)),
        ],
      ),
    );
  }
}
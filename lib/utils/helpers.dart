import 'package:flutter/material.dart';

import '../models/day_slot.dart';
import '../models/workout_card.dart';
import '../models/workout_data.dart';
import 'data.dart';

String getWeekOfMonth(DateTime date) {
  final firstDayOfMonth = DateTime(date.year, date.month, 1);

  final weekNumber =
      ((date.day + firstDayOfMonth.weekday - 2) ~/ 7) + 1;

  final totalWeeks =
      ((DateTime(date.year, date.month + 1, 0).day +
          firstDayOfMonth.weekday -
          2) ~/
          7) +
          1;

  return '$weekNumber/$totalWeeks';
}

WorkoutCard _workoutDataToCard(String id, WorkoutData data) {
  final title = data.title.toLowerCase();

  String category;
  Color categoryColor;
  IconData categoryIcon;

  if (title.contains('arm') || title.contains('upper') || title.contains('chest') || title.contains('shoulder')) {
    category = 'Arms Workout';
    categoryColor = const Color(0xFF00C853);
    categoryIcon = Icons.fitness_center;
  } else if (title.contains('leg') || title.contains('squat') || title.contains('glute')) {
    category = 'Leg Workout';
    categoryColor = const Color(0xFF7C4DFF);
    categoryIcon = Icons.directions_run;
  } else if (title.contains('core') || title.contains('abs') || title.contains('plank')) {
    category = 'Core & Abs';
    categoryColor = const Color(0xFFFF6D00);
    categoryIcon = Icons.sports_gymnastics;
  } else if (title.contains('cardio') || title.contains('run') || title.contains('cycle')) {
    category = 'Cardio';
    categoryColor = const Color(0xFFE53935);
    categoryIcon = Icons.directions_bike;
  } else if (title.contains('full') || title.contains('body')) {
    category = 'Full Body';
    categoryColor = const Color(0xFF00ACC1);
    categoryIcon = Icons.accessibility_new;
  } else {
    category = 'Workout';
    categoryColor = const Color(0xFFFFB300);
    categoryIcon = Icons.sports;
  }

  return WorkoutCard(
    id: id,
    category: category,
    categoryColor: categoryColor,
    categoryIcon: categoryIcon,
    name: data.title,
    minDuration: data.durationMinStart,
    maxDuration: data.durationMinEnd,
  );
}

List<DaySlot> buildInitialSchedule({
  int weeksBefore = 8,  // how many weeks before today to show
  int weeksAfter = 12,  // how many weeks after today to show
}) {
  final today = DateTime.now();

  final todayMonday = today.subtract(Duration(days: today.weekday - 1));
  final rangeStart = todayMonday.subtract(Duration(days: weeksBefore * 7));
  final rangeEnd   = todayMonday.add(Duration(days: (weeksAfter * 7) + 6)); // +6 to end on Sunday

  final slots = <DaySlot>[];
  var cursor = rangeStart;
  var cardCounter = 0;

  while (!cursor.isAfter(rangeEnd)) {
    final key =
        '${cursor.year}-${cursor.month.toString().padLeft(2, '0')}-${cursor.day.toString().padLeft(2, '0')}';

    final workouts = workoutSchedule[key] ?? [];
    final cards = workouts.map((w) {
      cardCounter++;
      return _workoutDataToCard('w$cardCounter', w);
    }).toList();

    slots.add(DaySlot(date: cursor, cards: cards));
    cursor = cursor.add(const Duration(days: 1));
  }

  return slots;
}
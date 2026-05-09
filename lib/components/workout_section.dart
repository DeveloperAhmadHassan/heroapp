import 'package:flutter/material.dart';

import '../components/weather_badge.dart';
import '../controllers/date_controller.dart';
import '../models/workout_data.dart';
import '../utils/data.dart';
import 'empty.dart';

class WorkoutsSection extends StatelessWidget {
  final double temperature;

  const WorkoutsSection({
    super.key,
    this.temperature = 9,
  });

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  String _formatCardDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime>(
      valueListenable: selectedDateNotifier,
      builder: (context, selectedDate, _) {

        final workouts =
            workoutSchedule[_dateKey(selectedDate)] ?? [];

        return Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Workouts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  WeatherBadge(temperature: temperature),
                ],
              ),
              const SizedBox(height: 14),
              Column(
                spacing: 10,
                children: workouts.isNotEmpty ? workouts.map((workout) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.08),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: _WorkoutCard(
                    key: ValueKey(_dateKey(selectedDate)),
                    date: selectedDate,
                    workout: workout,
                    formattedDate: _formatCardDate(selectedDate),
                  ),
                )).toList() : [
                  EmptyCard(
                    key: ValueKey('empty_${_dateKey(selectedDate)}'),
                    date: selectedDate,
                    formattedDate: _formatCardDate(selectedDate),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final DateTime date;
  final WorkoutData workout;
  final String formattedDate;

  const _WorkoutCard({
    super.key,
    required this.date,
    required this.workout,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF18181C),
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
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$formattedDate  ·  ${workout.durationMinStart}m - ${workout.durationMinEnd}m',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              workout.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import '../models/workout_data.dart';

final Map<String, List<WorkoutData>> workoutSchedule = {
  '2026-05-05': [
    const WorkoutData(
      title: 'Cardio Blast',
      durationMinStart: 30,
      durationMinEnd: 40,
    ),
  ],

  '2026-05-06': [
    const WorkoutData(
      title: 'Upper Body',
      durationMinStart: 25,
      durationMinEnd: 30,
    ),
  ],

  '2026-05-07': [
    const WorkoutData(
      title: 'Leg Day',
      durationMinStart: 30,
      durationMinEnd: 45,
    ),
    const WorkoutData(
      title: 'Core And Abs',
      durationMinStart: 30,
      durationMinEnd: 45,
    ),
  ],

  '2026-05-08': [
    const WorkoutData(
      title: 'Core & Abs',
      durationMinStart: 20,
      durationMinEnd: 25,
    ),
  ],

  '2026-05-09': [
    const WorkoutData(
      title: 'Full Body',
      durationMinStart: 40,
      durationMinEnd: 50,
    ),
  ],
};
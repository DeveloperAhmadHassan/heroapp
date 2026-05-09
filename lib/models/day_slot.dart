import '../models/workout_card.dart';

class DaySlot {
  final DateTime date;
  List<WorkoutCard> cards;

  DaySlot({required this.date, required this.cards});
}
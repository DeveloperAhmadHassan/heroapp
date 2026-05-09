import 'package:flutter/cupertino.dart';

class WorkoutCard {
  final String id;
  final String category;
  final Color categoryColor;
  final IconData categoryIcon;
  final String name;
  final int minDuration;
  final int maxDuration;

  WorkoutCard({
    required this.id,
    required this.category,
    required this.categoryColor,
    required this.categoryIcon,
    required this.name,
    required this.minDuration,
    required this.maxDuration,
  });

  WorkoutCard copyWith({String? id}) => WorkoutCard(
    id: id ?? this.id,
    category: category,
    categoryColor: categoryColor,
    categoryIcon: categoryIcon,
    name: name,
    minDuration: minDuration,
    maxDuration: maxDuration,
  );
}
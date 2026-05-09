import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../components/week_section.dart';
import '../models/day_slot.dart';
import '../models/workout_card.dart';
import '../utils/helpers.dart';

class TrainingCalendarScreen extends StatefulWidget {
  const TrainingCalendarScreen({super.key});

  @override
  State<TrainingCalendarScreen> createState() => _TrainingCalendarScreenState();
}

class _TrainingCalendarScreenState extends State<TrainingCalendarScreen> {
  late List<DaySlot> _schedule;
  late List<DaySlot> _originalSchedule;
  bool _isDirty = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _schedule = buildInitialSchedule();
    _originalSchedule = _deepCopy(_schedule);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToToday());
  }
  void _scrollToToday() {
    final today = DateTime.now();
    final todayMonday = today.subtract(Duration(days: today.weekday - 1));
    final rangeStart = todayMonday.subtract(const Duration(days: 8 * 7));

    final dayOffset = todayMonday.difference(rangeStart).inDays;
    final weekIndex = dayOffset ~/ 7;

    const headerHeight = 72.0;
    const dayRowHeight = 68.0;
    final offset = weekIndex * (headerHeight + 7 * dayRowHeight);

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }


  List<DaySlot> _deepCopy(List<DaySlot> source) {
    return source
        .map((s) => DaySlot(date: s.date, cards: List.from(s.cards)))
        .toList();
  }

  void _markDirty() => setState(() => _isDirty = true);

  void _onSave() {
    _originalSchedule = _deepCopy(_schedule);
    setState(() => _isDirty = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Training calendar saved!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _moveCard(WorkoutCard card, DateTime fromDate, DateTime toDate) {
    setState(() {
      final fromSlot = _schedule.firstWhere((s) =>
      s.date.year == fromDate.year &&
          s.date.month == fromDate.month &&
          s.date.day == fromDate.day);
      final toSlot = _schedule.firstWhere((s) =>
      s.date.year == toDate.year &&
          s.date.month == toDate.month &&
          s.date.day == toDate.day);
      fromSlot.cards.removeWhere((c) => c.id == card.id);
      toSlot.cards.add(card);
      _isDirty = true;
    });
  }

  List<List<DaySlot>> _groupByWeek() {
    final groups = <List<DaySlot>>[];
    for (var i = 0; i < _schedule.length; i += 7) {
      groups.add(_schedule.sublist(i, math.min(i + 7, _schedule.length)));
    }
    return groups;
  }

  int _totalWeekMinutes(List<DaySlot> week) {
    return week.fold(0, (sum, day) {
      return sum +
          day.cards.fold(0, (s, c) => s + ((c.minDuration + c.maxDuration) ~/ 2));
    });
  }

  String _weekDateRange(List<DaySlot> week) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    final first = week.first.date;
    final last = week.last.date;
    if (first.month == last.month) {
      return '${months[first.month - 1]} ${first.day}-${last.day}';
    }
    return '${months[first.month - 1]} ${first.day} - ${months[last.month - 1]} ${last.day}';
  }

  int _weekOfMonth(DateTime monday) {
    int count = 0;
    DateTime d = DateTime(monday.year, monday.month, 1);
    while (d.weekday != DateTime.monday) {
      d = d.add(const Duration(days: 1));
    }
    while (!d.isAfter(monday)) {
      count++;
      d = d.add(const Duration(days: 7));
    }
    return count;
  }

  int _weeksInMonth(DateTime monday) {
    int count = 0;
    DateTime d = DateTime(monday.year, monday.month, 1);
    while (d.weekday != DateTime.monday) {
      d = d.add(const Duration(days: 1));
    }
    final lastDay = DateTime(monday.year, monday.month + 1, 0);
    while (!d.isAfter(lastDay)) {
      count++;
      d = d.add(const Duration(days: 7));
    }
    return count;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weeks = _groupByWeek();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Training Calendar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 24),
        ),
        actions: [
          TextButton(
            onPressed: _isDirty ? _onSave : null,
            child: Text(
              'Save',
              style: TextStyle(
                color: _isDirty ? Colors.white : Colors.white30,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.green.withValues(alpha: 0.6)),
        ),
      ),
      body: CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, wi) {
              final week = weeks[wi];
              final monday = week.first.date;
              final weekNum = _weekOfMonth(monday);
              final totalWeeks = _weeksInMonth(monday);
              final totalMins = _totalWeekMinutes(week);

              return WeekSection(
                weekNumber: weekNum,
                totalWeeks: totalWeeks,
                dateRange: _weekDateRange(week),
                totalMinutes: totalMins,
                days: week,
                onCardMoved: _moveCard,
                onDirty: _markDirty,
              );
            },
            childCount: weeks.length,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
      ],
    ),
    );
  }
}


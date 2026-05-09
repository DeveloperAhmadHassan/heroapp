import 'package:flutter/material.dart';

class WeeklyCalendar extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  const WeeklyCalendar({super.key, this.onDateSelected});

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  late DateTime _selectedDate;
  late DateTime _today;
  late PageController _pageController;
  late DateTime _currentWeekStart;

  static const List<String> _weekDays = ['M', 'TU', 'W', 'TH', 'F', 'SA', 'SU'];

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _selectedDate = _today;
    _currentWeekStart = _getWeekStart(_today);
    _pageController = PageController(initialPage: 1000);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _getWeekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<DateTime> _getWeekDates(int pageIndex) {
    final offset = pageIndex - 1000;
    final weekStart = _currentWeekStart.add(Duration(days: offset * 7));
    return List.generate(7, (i) => weekStart.add(Duration(days: i)));
  }

  String _formatHeader() {
    return 'Today, ${_formatDate(_today)}';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  bool _isFuture(DateTime date) {
    final today = DateTime(_today.year, _today.month, _today.day);
    final d = DateTime(date.year, date.month, date.day);
    return d.isAfter(today);
  }

  bool _isToday(DateTime date) {
    return date.year == _today.year &&
        date.month == _today.month &&
        date.day == _today.day;
  }

  bool _isSelected(DateTime date) {
    return date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatHeader(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, pageIndex) {
                  final weekDates = _getWeekDates(pageIndex);

                  final weekStart = DateTime(
                      weekDates.first.year, weekDates.first.month, weekDates.first.day);
                  final today = DateTime(_today.year, _today.month, _today.day);
                  if (weekStart.isAfter(today)) {
                    return _buildDaysRow(_getWeekDates(1000));
                  }

                  return _buildDaysRow(weekDates);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysRow(List<DateTime> weekDates) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final date = weekDates[i];
        return _buildDayCell(
          dayLabel: _weekDays[i],
          date: date,
          isFuture: _isFuture(date),
          isSelected: _isSelected(date),
        );
      }),
    );
  }

  Widget _buildDayCell({
    required String dayLabel,
    required DateTime date,
    required bool isFuture,
    required bool isSelected,
  }) {
    const Color green = Color(0xFF20B76F);

    final Color textColor = isSelected
        ? Colors.white
        : Colors.white70;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedDate = date);
        widget.onDateSelected?.call(date);
      },
      child: SizedBox(
        width: 40,
        child: Column(
          children: [
            Text(
              dayLabel,
              style: TextStyle(
                color: Colors.white24,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2C2C2C),
                border: isSelected
                    ? Border.all(color: green, width: 2)
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 5),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isSelected ? 1.0 : 0.0,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
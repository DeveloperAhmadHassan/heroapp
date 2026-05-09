import 'package:flutter/material.dart';

void showCalendarSheet(
    BuildContext context, {
      required DateTime selectedDate,
      required ValueChanged<DateTime> onDateSelected,
    }) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => CalendarBottomSheet(
      selectedDate: selectedDate,
      onDateSelected: onDateSelected,
    ),
  );
}

class CalendarBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarBottomSheet({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  final DateTime _today = DateTime.now();

  static const List<String> _weekLabels = [
    'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'
  ];

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _focusedMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month);
  }

  void _prevMonth() => setState(() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
  });

  void _nextMonth() => setState(() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
  });

  bool _isFuture(DateTime date) {
    final today = DateTime(_today.year, _today.month, _today.day);
    return DateTime(date.year, date.month, date.day).isAfter(today);
  }

  bool _isToday(DateTime date) =>
      date.year == _today.year &&
          date.month == _today.month &&
          date.day == _today.day;

  bool _isSelected(DateTime date) =>
      date.year == _selectedDate.year &&
          date.month == _selectedDate.month &&
          date.day == _selectedDate.day;

  bool _isCurrentMonth(DateTime date) =>
      date.month == _focusedMonth.month && date.year == _focusedMonth.year;

  List<DateTime?> _buildGridDates() {
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final lastDay = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

    final leadingBlanks = (firstDay.weekday - 1) % 7;
    final cells = <DateTime?>[];

    for (var i = 0; i < leadingBlanks; i++) cells.add(null);
    for (var d = 1; d <= lastDay.day; d++) {
      cells.add(DateTime(_focusedMonth.year, _focusedMonth.month, d));
    }
    return cells;
  }

  @override
  Widget build(BuildContext context) {
    final gridDates = _buildGridDates();
    final rows = (gridDates.length / 7).ceil();

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF18181C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavButton(icon: Icons.chevron_left, onTap: _prevMonth),
              Text(
                '${_months[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _NavButton(icon: Icons.chevron_right, onTap: _nextMonth),
            ],
          ),
          const SizedBox(height: 16),

          // Weekday labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _weekLabels
                .map((l) => SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  l,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ))
                .toList(),
          ),
          const SizedBox(height: 8),

          Column(
            children: List.generate(rows, (row) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (col) {
                    final index = row * 7 + col;
                    final date = index < gridDates.length ? gridDates[index] : null;
                    return _DayCell(
                      date: date,
                      isSelected: date != null && _isSelected(date),
                      isToday: date != null && _isToday(date),
                      isFuture: date != null && _isFuture(date),
                      isCurrentMonth: date != null && _isCurrentMonth(date),
                      onTap: date == null || _isFuture(date)
                          ? null
                          : () {
                        setState(() => _selectedDate = date);
                        widget.onDateSelected(date);
                        Navigator.pop(context);
                      },
                    );
                  }),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final DateTime? date;
  final bool isSelected;
  final bool isToday;
  final bool isFuture;
  final bool isCurrentMonth;
  final VoidCallback? onTap;

  const _DayCell({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.isFuture,
    required this.isCurrentMonth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (date == null) return const SizedBox(width: 40, height: 40);

    Color textColor;
    if (isFuture) {
      textColor = Colors.white24;
    } else if (isSelected) {
      textColor = Colors.white;
    } else {
      textColor = Colors.white70;
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.green.withValues(alpha: 0.4) : Colors.transparent,
              border: isSelected
                  ? Border.all(color: const Color(0xFF00C853), width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                '${date!.day}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
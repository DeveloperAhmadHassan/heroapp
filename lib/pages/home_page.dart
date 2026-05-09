import 'package:flutter/material.dart';
import 'package:hero_app/components/weight_cards.dart';

import '../components/calendar_bottomsheet.dart';
import '../components/hydration_card.dart';
import '../components/weekly_calendar.dart';
import '../components/workout_section.dart';
import '../controllers/date_controller.dart';
import '../services/weather_service.dart';
import '../utils/helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  double? temperature;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final temp = await WeatherService.getTemperature();

      setState(() {
        temperature = temp;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Image.asset("assets/icons/icon_bell.png"),
          onPressed: () {
            // Handle bell icon tap
          },
        ),
        title: ValueListenableBuilder<DateTime>(
          valueListenable: selectedDateNotifier,
          builder: (context, selectedDate, _) {

            final weekText = getWeekOfMonth(selectedDate);

            return GestureDetector(
              onTap: () => showCalendarSheet(
                context,
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  selectedDateNotifier.value = date;
                },
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Image.asset("assets/icons/icon_week.png"),
                  Text(
                    'Week$weekText',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
                child: WeeklyCalendar(
                  onDateSelected: (date) {
                    selectedDateNotifier.value = date;
                  },
                ),
              ),
              WorkoutsSection(
                temperature: temperature ?? 0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("My Insights", style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  fontWeight: FontWeight.w600
                ),textAlign: TextAlign.start,),
              ),
              WeightCards(),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: HydrationCard(
                  currentMl: 500,
                  goalMl: 2000,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

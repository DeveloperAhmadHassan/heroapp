import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../pages/home_page.dart';
import '../pages/mood_page.dart';
import '../pages/profile_page.dart';
import '../pages/training_calendar_page.dart';
import 'components/nav_item.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Mulish',
      ),
      home: const HeroApp(),
    );
  }
}

class HeroApp extends StatefulWidget {
  const HeroApp({super.key});

  @override
  State<HeroApp> createState() => _HeroAppState();
}

class _HeroAppState extends State<HeroApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TrainingCalendarScreen(),
    const MoodPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 82,
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(
              color: Colors.white10,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              label: 'Nutrition',
              icon: 'assets/icons/icon_nutrition_selected.png',
              isSelected: _currentIndex == 0,
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),

            NavItem(
              label: 'Plan',
              icon: 'assets/icons/icon_plan_selected.png',
              isSelected: _currentIndex == 1,
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),

            NavItem(
              label: 'Mood',
              icon:'assets/icons/icon_mood_selected.png',
              isSelected: _currentIndex == 2,
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),

            NavItem(
              label: 'Profile',
              icon: 'assets/icons/icon_profile_unselected.png',
              isSelected: _currentIndex == 3,
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}



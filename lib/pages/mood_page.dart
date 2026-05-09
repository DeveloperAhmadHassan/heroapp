import 'dart:ui';

import 'package:flutter/material.dart';

import '../components/circular_progress_bar.dart';
class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  double _progress = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: -100,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 200,
                sigmaY: 200,
              ),
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFF47FFF6).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: -160,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 200,
                sigmaY: 200,
              ),
              child: Container(
                height: 300,
                width: 100,
                decoration: BoxDecoration(
                    color: Color(0xFFC547FF).withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: -120,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 200,
                sigmaY: 200,
              ),
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    color: Color(0xFF47B2FF).withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Mood", style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  fontWeight: .w400
                ),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Start your day", style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      fontWeight: .w400
                    ),),
                    Text("How are you feeling at the Moment", style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      fontWeight: .w600
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 35,),
              Center(
                child: HollowCircularProgressBar(
                  size: 240,
                  strokeWidth: 35,
                  progress: _progress,
                  knobColor: Colors.white,
                  knobRadius: 33,
                  backgroundGradientColors: const [
                    Color(0xFFC9BBEF),
                    Color(0xFFF28DB3),
                    Color(0xFFF99955),
                    Color(0xFF6EB9AD),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _progress = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  _progress <= 0.25
                      ? "Calm"
                      : _progress <= 0.50
                      ? "Content"
                      : _progress <= 0.75
                      ? "Peaceful"
                      : "Happy",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    fontWeight: .w500
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Continue", style: TextStyle(
                    fontSize: 16,
                  fontWeight: .w600
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

class WeatherBadge extends StatelessWidget {
  final double temperature;

  const WeatherBadge({super.key,
    required this.temperature,
  });

  bool get _isNight {
    final hour = DateTime.now().hour;
    return hour >= 18 || hour < 6;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _isNight
            ? Image.asset("assets/icons/icon_moon.png")
            : Image.asset("assets/icons/icon_sun.png"),

        const SizedBox(width: 5),

        Text(
          '${temperature.toInt()}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static final String _apiKey = dotenv.get('API_URL');

  static Future<double> getTemperature() async {
    final permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }

    final position = await Geolocator.getCurrentPosition();

    final url =
        'https://api.openweathermap.org/data/2.5/weather'
        '?lat=${position.latitude}'
        '&lon=${position.longitude}'
        '&units=metric'
        '&appid=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather');
    }

    final data = jsonDecode(response.body);

    return (data['main']['temp'] as num).toDouble();
  }
}
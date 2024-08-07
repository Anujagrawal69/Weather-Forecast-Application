import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.weather});
  final Weather weather;

  String getWeatherIcon(String main) {
    switch (main) {
      case 'Clear':
        return '🌞'; // Example icon for clear weather
      case 'Clouds':
        return '☁️'; // Example icon for cloudy weather
      case 'Rain':
        return '🌧️'; // Example icon for rain
      case 'Drizzle':
        return '🌦️'; // Example icon for drizzle
      case 'Thunderstorm':
        return '⛈️'; // Example icon for thunderstorm
      case 'Snow':
        return '❄️'; // Example icon for snow
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
      case 'Sand':
      case 'Ash':
        return '🌫️'; // Example icon for mist, smoke, haze, dust, fog, sand, ash
      case 'Squall':
        return '💨'; // Example icon for squall
      case 'Tornado':
        return '🌪️'; // Example icon for tornado
      default:
        return '🌈'; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${weather.temperature!.celsius!.toStringAsFixed(0)}\u00B0C',
              style: const TextStyle(color: Colors.white)),
          Text(
            getWeatherIcon(weather.weatherMain!),
            style:const TextStyle(fontSize: 30),
          ),
          Text(
            '${weather.date!.hour}:${weather.date!.minute}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

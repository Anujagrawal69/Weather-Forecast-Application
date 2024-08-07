import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/glow_text.dart';
import 'package:weather_app/date_time_info.dart';
import 'package:weather_app/show_other_options.dart';
import 'package:weather_app/weather_card.dart';
import 'package:weather_app/weather_service.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.cityName});
  final String cityName;

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _fetchWeather(widget.cityName);
    _startTimer();
  }

  Timer? _timer;
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchWeather(widget.cityName);
      _updateDateTime();
      _fetchWeatherSevenDays(widget.cityName);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  List<Weather> _sevenDaysWeather = [];

  Future<void> _fetchWeather(String city) async {
    try {
      Weather weather = await _weatherService.getCurrentWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> _fetchWeatherSevenDays(String city) async {
    try {
      List<Weather> fiveDayWeather =
          await _weatherService.getFiveDayForecast(city);
      setState(() {
        _sevenDaysWeather = fiveDayWeather.take(7).toList();
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(context) {
    return _build();
  }

  void _updateDateTime() {
    setState(() {
      _now = DateTime.now();
    });
  }

  DateTime? _now;
  Widget _dateTimeInfo({DateTime? now}) {
    if (_now == null) {
      return const Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return DateTimeInfo(
      noww: _now!,
    );
  }

  void _otherOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return const ShowOtherOptions();
      },
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

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

  Widget _build() {
    if (_weather == null) {
      return const Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 6, 1, 33),
                Color.fromARGB(255, 3, 12, 75),
                Color.fromARGB(255, 7, 1, 39),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(92, 12, 146, 255),
                          offset: Offset(0, 3),
                          spreadRadius: 3,
                          blurRadius: 10,
                          blurStyle: BlurStyle.solid,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 107, 187, 252),
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                          blurStyle: BlurStyle.solid,
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 95, 194, 255),
                            Color.fromARGB(255, 0, 64, 255)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  height: 610,
                  width: double.infinity,
                  child: SafeArea(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 34,
                                    ),
                                    Text(
                                      _weather?.areaName ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: _otherOptions,
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            child: GlowingText(
                              text: getWeatherIcon(
                                  _weather!.weatherMain.toString()),
                              fontSize: 150,
                              glowColor:
                                  const Color.fromARGB(255, 55, 242, 255),
                            ),
                          ),
                          SizedBox(
                              height: 100,
                              child: Text(
                                "${_weather?.temperature?.celsius?.toStringAsFixed(0)}\u00B0C",
                                style: const TextStyle(
                                  fontSize: 80,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Text(
                            (_weather?.weatherMain ?? "").toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _dateTimeInfo(now: _now),
                            ],
                          ),
                          const Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 1,
                            height: 40,
                            color: Color.fromARGB(255, 48, 156, 214),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    '🍃 ༄',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                      "${((_weather?.windSpeed)! * 18 / 5).toStringAsFixed(1)} Km/h",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const Text(
                                    'Wind',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 217, 214, 214),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    '💧',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text("${_weather?.humidity}%",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const Text(
                                    'Humidity',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 217, 214, 214),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    '🌫️',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    "${_weather?.tempFeelsLike!.celsius?.toStringAsFixed(0)}"
                                    "\u00B0C",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Feels Like',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 217, 214, 214),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 120,
                      margin: const EdgeInsets.only(
                        top: 4,
                        left: 10,
                        right: 10,
                        bottom: 4,
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 107, 187, 252),
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                              blurRadius: 5,
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 95, 194, 255),
                                Color.fromARGB(255, 0, 64, 255)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              "${_weather?.temperature?.celsius?.toStringAsFixed(0)}\u00B0C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            getWeatherIcon(_weather!.weatherMain!),
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            _sevenDaysWeather.isEmpty
                                ? ""
                                : '${_sevenDaysWeather[0].date!.hour}:${_sevenDaysWeather[0].date!.minute}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: _sevenDaysWeather.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  Weather weather =
                                      _sevenDaysWeather[index + 1];
                                  return WeatherCard(weather: weather);
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

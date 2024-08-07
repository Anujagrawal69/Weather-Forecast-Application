import 'package:weather/weather.dart';

class WeatherService {
  final WeatherFactory _weatherFactory;
  // final String _apiKey = '23a9bdc5d3d5726b43e0cbc93c54dc2e';

  WeatherService()
      : _weatherFactory = WeatherFactory('23a9bdc5d3d5726b43e0cbc93c54dc2e');

  Future<Weather> getCurrentWeather(String city) async {
    return await _weatherFactory.currentWeatherByCityName(city);
  }

  Future<List<Weather>> getFiveDayForecast(String city) async {
    return await _weatherFactory.fiveDayForecastByCityName(city);
  }
}

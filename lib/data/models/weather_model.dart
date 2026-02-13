import 'package:practice_test/domain/entities/weather_entity.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.feelsLike,
    required super.description,
    required super.main,
    required super.icon,
    required super.humidity,
    required super.pressure,
    required super.windSpeed,
    super.windGust,
    super.clouds,
    super.visibility,
    super.uvi,
    super.sunrise,
    super.sunset,
  });

  // For Current Weather API: /weather endpoint
  factory WeatherModel.fromCurrentWeatherJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      main: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      pressure: json['main']['pressure'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windGust: json['wind']['gust'] != null
          ? (json['wind']['gust'] as num).toDouble()
          : null,
      clouds: json['clouds']?['all'],
      visibility: json['visibility'],
      sunrise: json['sys']['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000)
          : null,
      sunset: json['sys']['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000)
          : null,
    );
  }

  // For One Call API: current data
  factory WeatherModel.fromOneCallCurrentJson(
    Map<String, dynamic> json,
    String cityName,
  ) {
    return WeatherModel(
      cityName: cityName,
      temperature: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      main: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['humidity'] ?? 0,
      pressure: json['pressure'] ?? 0,
      windSpeed: (json['wind_speed'] as num).toDouble(),
      windGust: json['wind_gust'] != null
          ? (json['wind_gust'] as num).toDouble()
          : null,
      clouds: json['clouds'],
      visibility: json['visibility'],
      uvi: json['uvi'] != null ? (json['uvi'] as num).toDouble() : null,
      sunrise: json['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000)
          : null,
      sunset: json['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000)
          : null,
    );
  }
}

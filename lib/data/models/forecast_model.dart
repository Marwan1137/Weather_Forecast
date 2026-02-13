import 'package:practice_test/domain/entities/forecast_entity.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required super.dateTime,
    required super.tempDay,
    required super.tempMin,
    required super.tempMax,
    required super.tempMorn,
    required super.tempEve,
    required super.tempNight,
    required super.description,
    required super.main,
    required super.icon,
    required super.humidity,
    required super.windSpeed,
    required super.clouds,
    super.pop,
    super.uvi,
  });

  // For One Call API: daily forecast
  factory ForecastModel.fromDailyJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      tempDay: (json['temp']['day'] as num).toDouble(),
      tempMin: (json['temp']['min'] as num).toDouble(),
      tempMax: (json['temp']['max'] as num).toDouble(),
      tempMorn: (json['temp']['morn'] as num).toDouble(),
      tempEve: (json['temp']['eve'] as num).toDouble(),
      tempNight: (json['temp']['night'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      main: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['humidity'] ?? 0,
      windSpeed: (json['wind_speed'] as num).toDouble(),
      clouds: json['clouds'] ?? 0,
      pop: json['pop'] != null ? (json['pop'] as num).toDouble() : null,
      uvi: json['uvi'] != null ? (json['uvi'] as num).toDouble() : null,
    );
  }

  // For 5-day forecast API (if you use this instead)
  factory ForecastModel.from5DayJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      tempDay: (json['main']['temp'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      tempMorn: (json['main']['temp'] as num).toDouble(), // Same as day
      tempEve: (json['main']['temp'] as num).toDouble(), // Same as day
      tempNight: (json['main']['temp'] as num).toDouble(), // Same as day
      description: json['weather'][0]['description'] ?? '',
      main: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      clouds: json['clouds']?['all'] ?? 0,
      pop: json['pop'] != null ? (json['pop'] as num).toDouble() : null,
    );
  }
}

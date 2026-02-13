import 'package:practice_test/domain/entities/forecast_entity.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required super.dateTime,
    required super.temperature,
    required super.tempMin,
    required super.tempMax,
    required super.description,
    required super.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt_txt': dateTime.toIso8601String(),
      'main': {'temp': temperature, 'temp_min': tempMin, 'temp_max': tempMax},
      'weather': [
        {'description': description, 'icon': icon},
      ],
    };
  }
}

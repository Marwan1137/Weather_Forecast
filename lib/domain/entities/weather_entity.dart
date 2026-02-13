import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final double feelsLike;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.feelsLike,
  });

  @override
  List<Object?> get props => [
    cityName,
    temperature,
    description,
    icon,
    humidity,
    windSpeed,
    pressure,
    feelsLike,
  ];
}

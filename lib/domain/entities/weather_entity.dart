import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String description;
  final String main; // Rain, Snow, Clear, etc.
  final String icon;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final double? windGust;
  final int? clouds;
  final int? visibility;
  final double? uvi;
  final DateTime? sunrise;
  final DateTime? sunset;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.main,
    required this.icon,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    this.windGust,
    this.clouds,
    this.visibility,
    this.uvi,
    this.sunrise,
    this.sunset,
  });

  @override
  List<Object?> get props => [
    cityName,
    temperature,
    feelsLike,
    description,
    main,
    icon,
    humidity,
    pressure,
    windSpeed,
    windGust,
    clouds,
    visibility,
    uvi,
    sunrise,
    sunset,
  ];
}

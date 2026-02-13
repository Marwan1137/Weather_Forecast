import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final DateTime dateTime;
  final double tempDay;
  final double tempMin;
  final double tempMax;
  final double tempMorn;
  final double tempEve;
  final double tempNight;
  final String description;
  final String main;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int clouds;
  final double? pop; // Probability of precipitation (0-1)
  final double? uvi;

  const Forecast({
    required this.dateTime,
    required this.tempDay,
    required this.tempMin,
    required this.tempMax,
    required this.tempMorn,
    required this.tempEve,
    required this.tempNight,
    required this.description,
    required this.main,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.clouds,
    this.pop,
    this.uvi,
  });

  @override
  List<Object?> get props => [
    dateTime,
    tempDay,
    tempMin,
    tempMax,
    tempMorn,
    tempEve,
    tempNight,
    description,
    main,
    icon,
    humidity,
    windSpeed,
    clouds,
    pop,
    uvi,
  ];
}

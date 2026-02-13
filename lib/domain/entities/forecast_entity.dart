import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;

  const Forecast({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [
    dateTime,
    temperature,
    tempMin,
    tempMax,
    description,
    icon,
  ];
}

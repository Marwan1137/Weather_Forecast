part of 'weather_cubit.dart';

sealed class WeatherCubitState extends Equatable {
  const WeatherCubitState();

  @override
  List<Object> get props => [];
}

final class WeatherCubitInitial extends WeatherCubitState {}

final class WeatherCubitLoading extends WeatherCubitState {}

final class WeatherCubitLoaded extends WeatherCubitState {
  final Weather weather;
  final List<Forecast> forecast;
  const WeatherCubitLoaded({
    required this.weather,
    required this.forecast,
  });

  @override
  List<Object> get props => [weather, forecast];
}

final class WeatherCubitError extends WeatherCubitState {
  final String message;
  const WeatherCubitError({required this.message});
  @override
  List<Object> get props => [message];
}

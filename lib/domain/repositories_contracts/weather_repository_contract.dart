import 'package:injectable/injectable.dart';
import 'package:practice_test/data/models/forecast_model.dart';
import 'package:practice_test/data/models/weather_model.dart';

abstract class WeatherRepositoryContract {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<List<ForecastModel>> getForecast(String cityName);
}

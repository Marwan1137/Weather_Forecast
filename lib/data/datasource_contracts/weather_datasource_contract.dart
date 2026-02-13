import 'package:practice_test/data/models/forecast_model.dart';
import 'package:practice_test/data/models/weather_model.dart';

abstract class WeatherDatasourceContract {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<List<ForecastModel>> getForecast(String cityName);
}

import 'package:practice_test/domain/entities/forecast_entity.dart';
import 'package:practice_test/domain/entities/weather_entity.dart';

abstract class WeatherRepositoryContract {
  Future<Weather> getCurrentWeather(String cityName);
  Future<List<Forecast>> getForecast(String cityName);
}

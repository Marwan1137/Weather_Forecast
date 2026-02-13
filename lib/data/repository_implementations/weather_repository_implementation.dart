import 'package:injectable/injectable.dart';
import 'package:practice_test/data/datasource_contracts/weather_datasource_contract.dart';
import 'package:practice_test/domain/entities/forecast_entity.dart';
import 'package:practice_test/domain/entities/weather_entity.dart';
import 'package:practice_test/domain/repositories_contracts/weather_repository_contract.dart';

@Injectable(as: WeatherRepositoryContract)
class WeatherRepositoryImplementation implements WeatherRepositoryContract {
  final WeatherDatasourceContract datasource;
  WeatherRepositoryImplementation({required this.datasource});

  @override
  Future<Weather> getCurrentWeather(String cityName) async {
    return await datasource.getCurrentWeather(cityName);
  }

  @override
  Future<List<Forecast>> getForecast(String cityName) async {
    return await datasource.getForecast(cityName);
  }

  @override
  Future<Weather> getCurrentWeatherByCoords(double lat, double lon) async {
    return await datasource.getCurrentWeatherByCoords(lat, lon);
  }

  @override
  Future<List<Forecast>> getForecastByCoords(double lat, double lon) async {
    return await datasource.getForecastByCoords(lat, lon);
  }
}

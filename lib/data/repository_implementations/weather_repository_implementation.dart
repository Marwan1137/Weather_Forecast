import 'package:injectable/injectable.dart';
import 'package:practice_test/data/datasource_contracts/weather_datasource_contract.dart';
import 'package:practice_test/data/models/forecast_model.dart';
import 'package:practice_test/data/models/weather_model.dart';
import 'package:practice_test/domain/repositories_contracts/weather_repository_contract.dart';

@Injectable(as: WeatherRepositoryContract)
class WeatherRepositoryImplementation implements WeatherRepositoryContract {
  final WeatherDatasourceContract datasource;
  WeatherRepositoryImplementation({required this.datasource});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    return await datasource.getCurrentWeather(cityName);
  }

  @override
  Future<List<ForecastModel>> getForecast(String cityName) async {
    return await datasource.getForecast(cityName);
  }
}

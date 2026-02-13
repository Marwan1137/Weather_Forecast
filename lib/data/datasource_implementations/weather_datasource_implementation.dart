import 'package:practice_test/core/error/exceptions.dart';
import 'package:practice_test/core/network/api_client.dart';
import 'package:practice_test/core/network/api_constants.dart';
import 'package:practice_test/data/datasource_contracts/weather_datasource_contract.dart';
import 'package:practice_test/data/models/forecast_model.dart';
import 'package:practice_test/data/models/weather_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherDatasourceContract)
class WeatherDatasourceImplementation implements WeatherDatasourceContract {
  final ApiClient apiClient;

  WeatherDatasourceImplementation({required this.apiClient});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final queryParams = {
        'q': cityName,
        'appid': ApiConstants.apiKey,
        'units': ApiConstants.units,
      };

      final response = await apiClient.get(
        ApiConstants.currentWeather,
        queryParameters: queryParams,
      );

      return WeatherModel.fromCurrentWeatherJson(response);
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to get current weather: ${e.toString()}');
    }
  }

  @override
  Future<List<ForecastModel>> getForecast(String cityName) async {
    try {
      final queryParams = {
        'q': cityName,
        'appid': ApiConstants.apiKey,
        'units': ApiConstants.units,
      };

      final response = await apiClient.get(
        ApiConstants.forecast5Day,
        queryParameters: queryParams,
      );

      final List<dynamic> forecastList =
          response['list'] as List<dynamic>? ?? [];
      return forecastList
          .map(
            (json) => ForecastModel.from5DayJson(json as Map<String, dynamic>),
          )
          .toList();
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to get forecast: ${e.toString()}');
    }
  }
}

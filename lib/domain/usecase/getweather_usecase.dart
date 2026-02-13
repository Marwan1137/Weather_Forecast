import 'package:injectable/injectable.dart';
import 'package:practice_test/data/models/weather_model.dart';
import 'package:practice_test/domain/repositories_contracts/weather_repository_contract.dart';

@injectable
class GetWeatherUsecase {
  final WeatherRepositoryContract repo;
  GetWeatherUsecase({required this.repo});

  Future<WeatherModel> call(String cityName) async {
    return await repo.getCurrentWeather(cityName);
  }
}

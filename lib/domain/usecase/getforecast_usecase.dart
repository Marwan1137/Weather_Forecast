import 'package:injectable/injectable.dart';
import 'package:practice_test/data/models/forecast_model.dart';
import 'package:practice_test/domain/repositories_contracts/weather_repository_contract.dart';

@injectable
class GetForecastUsecase {
  final WeatherRepositoryContract repo;
  GetForecastUsecase({required this.repo});

  Future<List<ForecastModel>> call(String cityName) async {
    return await repo.getForecast(cityName);
  }
}

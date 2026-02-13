import 'package:injectable/injectable.dart';
import 'package:practice_test/domain/entities/forecast_entity.dart';
import 'package:practice_test/domain/repositories_contracts/weather_repository_contract.dart';

@injectable
class GetForecastUsecase {
  final WeatherRepositoryContract repo;
  GetForecastUsecase({required this.repo});

  Future<List<Forecast>> call(String cityName) async {
    return await repo.getForecast(cityName);
  }
}

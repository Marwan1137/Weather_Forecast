import 'package:injectable/injectable.dart';
import 'package:practice_test/domain/entities/forecast_entity.dart';
import 'package:practice_test/domain/repositories_contracts/weather_repository_contract.dart';

@injectable
class GetForecastByLocationUsecase {
  final WeatherRepositoryContract repo;
  GetForecastByLocationUsecase({required this.repo});

  Future<List<Forecast>> call(double lat, double lon) async {
    return await repo.getForecastByCoords(lat, lon);
  }
}

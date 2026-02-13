import 'package:injectable/injectable.dart';
import 'package:practice_test/domain/entities/weather_entity.dart';
import 'package:practice_test/domain/repositories_contracts/weather_repository_contract.dart';

@injectable
class GetWeatherByLocationUsecase {
  final WeatherRepositoryContract repo;
  GetWeatherByLocationUsecase({required this.repo});

  Future<Weather> call(double lat, double lon) async {
    return await repo.getCurrentWeatherByCoords(lat, lon);
  }
}

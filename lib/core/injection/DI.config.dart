// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasource_contracts/weather_datasource_contract.dart'
    as _i517;
import '../../data/datasource_implementations/weather_datasource_implementation.dart'
    as _i88;
import '../../data/repository_implementations/weather_repository_implementation.dart'
    as _i237;
import '../../domain/repositories_contracts/weather_repository_contract.dart'
    as _i80;
import '../../domain/usecase/getforecast_usecase.dart' as _i200;
import '../../domain/usecase/getweather_usecase.dart' as _i107;
import '../network/api_client.dart' as _i557;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient());
    gh.factory<_i517.WeatherDatasourceContract>(
      () => _i88.WeatherDatasourceImplementation(
        apiClient: gh<_i557.ApiClient>(),
      ),
    );
    gh.factory<_i80.WeatherRepositoryContract>(
      () => _i237.WeatherRepositoryImplementation(
        datasource: gh<_i517.WeatherDatasourceContract>(),
      ),
    );
    gh.factory<_i200.GetForecastUsecase>(
      () =>
          _i200.GetForecastUsecase(repo: gh<_i80.WeatherRepositoryContract>()),
    );
    gh.factory<_i107.GetWeatherUsecase>(
      () => _i107.GetWeatherUsecase(repo: gh<_i80.WeatherRepositoryContract>()),
    );
    return this;
  }
}

// ignore_for_file: file_names

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:practice_test/data/datasource_contracts/weather_datasource_contract.dart';
import 'package:practice_test/data/datasource_implementations/weather_datasource_implementation.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  // Initialize generated dependencies
  getIt.init();

  if (!getIt.isRegistered<WeatherDatasourceContract>()) {
    getIt.registerFactory<WeatherDatasourceContract>(
      () => getIt<WeatherDatasourceImplementation>(),
    );
  }
}

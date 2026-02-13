import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:practice_test/core/error/exceptions.dart';
import 'package:practice_test/domain/entities/forecast_entity.dart';
import 'package:practice_test/domain/entities/weather_entity.dart';
import 'package:practice_test/domain/usecase/get_forecast_by_location_usecase.dart';
import 'package:practice_test/domain/usecase/get_weather_by_location_usecase.dart';
import 'package:practice_test/domain/usecase/getforecast_usecase.dart';
import 'package:practice_test/domain/usecase/getweather_usecase.dart';
part 'weather_cubit_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherCubitState> {
  final GetWeatherUsecase _getWeather;
  final GetForecastUsecase _getForecast;
  final GetWeatherByLocationUsecase _getWeatherByLocation;
  final GetForecastByLocationUsecase _getForecastByLocation;

  WeatherCubit({
    required GetWeatherUsecase getWeatherUsecase,
    required GetForecastUsecase getForecastUsecase,
    required GetWeatherByLocationUsecase getWeatherByLocationUsecase,
    required GetForecastByLocationUsecase getForecastByLocationUsecase,
  })  : _getWeather = getWeatherUsecase,
        _getForecast = getForecastUsecase,
        _getWeatherByLocation = getWeatherByLocationUsecase,
        _getForecastByLocation = getForecastByLocationUsecase,
        super(WeatherCubitInitial());

  Future<void> loadByLocation(double lat, double lon) async {
    emit(WeatherCubitLoading());
    try {
      final weather = await _getWeatherByLocation(lat, lon);
      final forecast = await _getForecastByLocation(lat, lon);
      emit(WeatherCubitLoaded(weather: weather, forecast: forecast));
    } on AppException catch (e) {
      emit(WeatherCubitError(message: e.message));
    } catch (_) {
      emit(const WeatherCubitError(message: 'Unexpected error'));
    }
  }

  Future<void> loadByCity(String cityName) async {
    emit(WeatherCubitLoading());
    try {
      final weather = await _getWeather(cityName);
      final forecast = await _getForecast(cityName);
      emit(WeatherCubitLoaded(weather: weather, forecast: forecast));
    } on AppException catch (e) {
      emit(WeatherCubitError(message: e.message));
    } catch (_) {
      emit(const WeatherCubitError(message: 'Unexpected error'));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:practice_test/core/error/exceptions.dart';
import 'package:practice_test/domain/entities/forecast_entity.dart';
import 'package:practice_test/domain/entities/weather_entity.dart';
import 'package:practice_test/domain/usecase/getforecast_usecase.dart';
import 'package:practice_test/domain/usecase/getweather_usecase.dart';
part 'weather_cubit_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherCubitState> {
  final GetWeatherUsecase _getWeather;
  final GetForecastUsecase _getForecast;

  WeatherCubit({
    required GetWeatherUsecase getWeatherUsecase,
    required GetForecastUsecase getForecastUsecase,
  }) : _getWeather = getWeatherUsecase,
       _getForecast = getForecastUsecase,
       super(WeatherCubitInitial());

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

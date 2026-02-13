import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String oneCallBaseUrl = 'https://api.openweathermap.org/data/3.0';
  
  // Your API Key - loaded from .env file
  static String get apiKey => dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  
  // Endpoints
  static const String currentWeather = '/weather'; // Current weather by city
  static const String oneCall = '/onecall'; // One Call API (current + forecast)
  static const String forecast5Day = '/forecast'; // 5-day forecast
  
  // Parameters - loaded from .env file
  static String get units => dotenv.env['DEFAULT_UNITS'] ?? 'metric'; // Defaults to metric (Celsius)
  
  // Icon URL
  static String getIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}

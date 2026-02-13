import 'package:flutter/material.dart';

/// Maps weather condition (main + icon) to gradient and foreground color.
class WeatherTheme {
  WeatherTheme._();

  static LinearGradient gradient(String main, String icon) {
    final isNight = icon.endsWith('n');
    switch (main.toLowerCase()) {
      case 'clear':
        if (isNight) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a237e),
              Color(0xFF0d47a1),
            ],
          );
        }
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFff9800),
            Color(0xFFffeb3b),
          ],
        );
      case 'clouds':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF37474f),
            Color(0xFF455a64),
          ],
        );
      case 'rain':
      case 'drizzle':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF546e7a),
            Color(0xFF78909c),
          ],
        );
      case 'thunderstorm':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF311b92),
            Color(0xFF4a148c),
          ],
        );
      case 'snow':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFb0bec5),
            Color(0xFFcfd8dc),
          ],
        );
      case 'mist':
      case 'fog':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF607d8b),
            Color(0xFF90a4ae),
          ],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF37474f),
            Color(0xFF546e7a),
          ],
        );
    }
  }

  static bool isDark(String main, String icon) {
    final isNight = icon.endsWith('n');
    switch (main.toLowerCase()) {
      case 'clear':
        return isNight;
      case 'thunderstorm':
        return true;
      case 'clouds':
      case 'rain':
      case 'drizzle':
        return true;
      case 'snow':
      case 'mist':
      case 'fog':
        return false;
      default:
        return true;
    }
  }

  static Color foregroundColor(String main, String icon) {
    return isDark(main, icon) ? Colors.white : Colors.black87;
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:practice_test/core/network/api_constants.dart';
import 'package:practice_test/domain/entities/forecast_entity.dart';
import 'package:practice_test/domain/entities/weather_entity.dart';
import 'package:practice_test/presentation/cubit/cubit/weather_cubit.dart';
import 'package:practice_test/presentation/utils/weather_theme.dart';

/// Design constants: spacing 8, 16, 24; radius 12; secondary opacity 0.85.
const _kSpacing8 = 8.0;
const _kSpacing16 = 16.0;
const _kSpacing24 = 24.0;
const _kRadius = 12.0;
const _kSecondaryOpacity = 0.85;

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  int _selectedTabIndex = 0;
  final List<String> _savedCityNames = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherCubitState>(
      builder: (context, state) {
        if (state is WeatherCubitLoading) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: WeatherTheme.gradient('Clear', '01d'),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          );
        }
        if (state is WeatherCubitError) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: WeatherTheme.gradient('Clouds', '04d'),
              ),
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(_kSpacing24),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        if (state is WeatherCubitLoaded) {
          final fg = WeatherTheme.foregroundColor(
            state.weather.main,
            state.weather.icon,
          );
          final dailyForecasts = _aggregateDaily(state.forecast);
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: WeatherTheme.gradient(
                  state.weather.main,
                  state.weather.icon,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      bottom: false,
                      child: IndexedStack(
                        index: _selectedTabIndex,
                        children: [
                          _buildForecastTabContent(
                            context,
                            state.weather,
                            dailyForecasts,
                            fg,
                          ),
                          _buildCitiesTabContent(context, fg),
                        ],
                      ),
                    ),
                  ),
                  _bottomNav(context, fg),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildForecastTabContent(
    BuildContext context,
    Weather weather,
    List<({String dayLabel, String iconUrl, double tempHigh, double tempLow})>
        dailyForecasts,
    Color fg,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _kSpacing16,
            vertical: _kSpacing8,
          ),
          child: TextField(
            style: TextStyle(color: fg),
            onSubmitted: (value) {
              final query = value.trim();
              if (query.isNotEmpty) {
                context.read<WeatherCubit>().loadByCity(query);
              }
            },
            decoration: InputDecoration(
              hintText: 'Search for a city...',
              hintStyle: TextStyle(
                  color: fg.withOpacity(_kSecondaryOpacity)),
              prefixIcon: Icon(Icons.search, color: fg),
              filled: true,
              fillColor: fg.withOpacity(0.15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kRadius),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: _kSpacing16,
                vertical: 14,
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              _kSpacing16,
              0,
              _kSpacing16,
              _kSpacing24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: _kSpacing8),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: _kSpacing8,
                  runSpacing: _kSpacing8,
                  children: [
                    Icon(Icons.location_on, size: 22, color: fg),
                    Text(
                      weather.cityName,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: fg),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM').format(DateTime.now()),
                      style: TextStyle(
                        color: fg.withOpacity(_kSecondaryOpacity),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: _kSpacing24),
                Text(
                  '${weather.temperature.toStringAsFixed(0)}°',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: fg,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                const SizedBox(height: _kSpacing8),
                Image.network(
                  ApiConstants.getIconUrl(weather.icon),
                  width: 80,
                  height: 80,
                  errorBuilder: (_, Object e, Object? st) =>
                      Icon(Icons.wb_sunny, size: 80, color: fg),
                ),
                Text(
                  weather.description,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: fg),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: _kSpacing24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _detailTile(
                      context,
                      icon: Icons.water_drop_outlined,
                      label: 'HUMIDITY',
                      value: '${weather.humidity}%',
                      fg: fg,
                    ),
                    _detailTile(
                      context,
                      icon: Icons.air_outlined,
                      label: 'WIND',
                      value:
                          '${(weather.windSpeed * 3.6).toStringAsFixed(0)} km/h',
                      fg: fg,
                    ),
                    _detailTile(
                      context,
                      icon: Icons.light_mode_outlined,
                      label: 'UV INDEX',
                      value:
                          weather.uvi != null ? '${weather.uvi!.round()}' : '—',
                      fg: fg,
                    ),
                  ],
                ),
                const SizedBox(height: _kSpacing24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '7-Day Forecast',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: fg,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: _kSpacing8),
                SizedBox(
                  height: 128,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dailyForecasts.length,
                    itemBuilder: (context, index) {
                      final d = dailyForecasts[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: _kSpacing16),
                        child: _dayCard(
                          context,
                          dayLabel: d.dayLabel,
                          iconUrl: d.iconUrl,
                          high: d.tempHigh,
                          low: d.tempLow,
                          fg: fg,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: _kSpacing24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCitiesTabContent(BuildContext context, Color fg) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _kSpacing16,
            vertical: _kSpacing8,
          ),
          child: TextField(
            style: TextStyle(color: fg),
            decoration: InputDecoration(
              hintText: 'Add a city...',
              hintStyle: TextStyle(
                  color: fg.withOpacity(_kSecondaryOpacity)),
              prefixIcon: Icon(Icons.add_location_alt_outlined, color: fg),
              filled: true,
              fillColor: fg.withOpacity(0.15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kRadius),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: _kSpacing16,
                vertical: 14,
              ),
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isEmpty) return;
              setState(() {
                if (!_savedCityNames.contains(trimmed)) {
                  _savedCityNames.add(trimmed);
                }
              });
            },
          ),
        ),
        Expanded(
          child: _savedCityNames.isEmpty
              ? Center(
                  child: Text(
                    'No saved cities.\nAdd one above.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fg.withOpacity(_kSecondaryOpacity),
                      fontSize: 14,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: _kSpacing16),
                  itemCount: _savedCityNames.length,
                  itemBuilder: (context, index) {
                    final city = _savedCityNames[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: _kSpacing8),
                      child: Material(
                        color: fg.withOpacity(0.12),
                        borderRadius:
                            BorderRadius.circular(_kRadius),
                        child: InkWell(
                          onTap: () {
                            context.read<WeatherCubit>().loadByCity(city);
                            setState(() => _selectedTabIndex = 0);
                          },
                          borderRadius:
                              BorderRadius.circular(_kRadius),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: _kSpacing16,
                              vertical: _kSpacing16,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_city_outlined,
                                  color: fg,
                                  size: 24,
                                ),
                                const SizedBox(width: _kSpacing16),
                                Text(
                                  city,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: fg),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _bottomNav(BuildContext context, Color fg) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const labels = ['Forecast', 'Cities'];
    const icons = [
      Icons.calendar_today_outlined,
      Icons.location_city_outlined,
    ];
    return Container(
      padding: EdgeInsets.only(
        top: _kSpacing16,
        bottom: _kSpacing8 + bottomPadding,
        left: _kSpacing16,
        right: _kSpacing16,
      ),
      decoration: BoxDecoration(
        color: fg.withOpacity(0.12),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_kRadius * 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(2, (i) {
          final selected = _selectedTabIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = i),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: _kSpacing8,
                horizontal: _kSpacing16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icons[i],
                    size: 24,
                    color: selected ? fg : fg.withOpacity(_kSecondaryOpacity),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[i],
                    style: TextStyle(
                      color: selected ? fg : fg.withOpacity(_kSecondaryOpacity),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _detailTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color fg,
  }) {
    return Column(
      children: [
        Icon(icon, size: 28, color: fg),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: fg,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: fg.withOpacity(_kSecondaryOpacity),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _dayCard(
    BuildContext context, {
    required String dayLabel,
    required String iconUrl,
    required double high,
    required double low,
    required Color fg,
  }) {
    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(
          vertical: 12, horizontal: _kSpacing8),
      decoration: BoxDecoration(
        color: fg.withOpacity(0.12),
        borderRadius: BorderRadius.circular(_kRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayLabel,
            style: TextStyle(
              color: fg,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Image.network(
            iconUrl,
            width: 36,
            height: 36,
            errorBuilder: (_, _, _) =>
                Icon(Icons.cloud_outlined, size: 36, color: fg),
          ),
          const SizedBox(height: 4),
          Text(
            '${high.toStringAsFixed(0)}°',
            style: TextStyle(
              color: fg,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${low.toStringAsFixed(0)}°',
            style: TextStyle(
              color: fg.withOpacity(_kSecondaryOpacity),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Aggregates 3-hour forecast list into one entry per calendar day.
  List<({String dayLabel, String iconUrl, double tempHigh, double tempLow})>
  _aggregateDaily(List<Forecast> forecast) {
    if (forecast.isEmpty) return [];
    final byDay = <DateTime, List<Forecast>>{};
    for (final f in forecast) {
      final d = DateTime(f.dateTime.year, f.dateTime.month, f.dateTime.day);
      byDay.putIfAbsent(d, () => []).add(f);
    }
    final sortedDates = byDay.keys.toList()..sort();
    final result =
        <
          ({String dayLabel, String iconUrl, double tempHigh, double tempLow})
        >[];
    for (final date in sortedDates.take(7)) {
      final list = byDay[date]!;
      final tempHigh = list
          .map((e) => e.tempMax)
          .reduce((a, b) => a > b ? a : b);
      final tempLow = list
          .map((e) => e.tempMin)
          .reduce((a, b) => a < b ? a : b);
      final noon = DateTime(date.year, date.month, date.day, 12, 0);
      list.sort(
        (a, b) => (a.dateTime.difference(noon).inMinutes.abs()).compareTo(
          b.dateTime.difference(noon).inMinutes.abs(),
        ),
      );
      final representative = list.first;
      result.add((
        dayLabel: DateFormat('EEE').format(date).toUpperCase(),
        iconUrl: ApiConstants.getIconUrl(representative.icon),
        tempHigh: tempHigh,
        tempLow: tempLow,
      ));
    }
    return result;
  }
}

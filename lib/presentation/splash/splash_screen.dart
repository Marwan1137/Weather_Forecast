// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:practice_test/presentation/cubit/cubit/weather_cubit.dart';
import 'package:practice_test/presentation/home_screen/weather_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInitialWeather());
  }

  Future<void> _loadInitialWeather() async {
    final cubit = context.read<WeatherCubit>();
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await cubit.loadByCity('London');
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      await cubit.loadByLocation(position.latitude, position.longitude);
    } catch (_) {
      await cubit.loadByCity('London');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherCubit, WeatherCubitState>(
      listener: (context, state) {
        if (state is WeatherCubitLoaded || state is WeatherCubitError) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const WeatherHomeScreen()),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFe65100), Color(0xFFbf360c)],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                const Text(
                  'WeatherNow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'YOUR SKY, SIMPLIFIED',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(flex: 2),
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
                const SizedBox(height: 16),
                Text(
                  'CHECKING LOCAL FORECAST...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_test/core/injection/di.dart';
import 'package:practice_test/presentation/cubit/cubit/weather_cubit.dart';
import 'package:practice_test/presentation/splash/splash_screen.dart';

void main() async {
  // Load environment variables FIRST (ApiClient needs them)
  // Note: .env file is at lib/.env, and asset path in pubspec.yaml is lib/.env
  await dotenv.load(fileName: "lib/.env");

  // Then initialize dependency injection
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherCubit>(),
      child: MaterialApp(
        title: 'Weather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

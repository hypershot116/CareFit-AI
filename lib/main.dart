import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carefit_ai/theme/app_theme.dart';
import 'package:carefit_ai/screens/onboarding_screen.dart';
import 'package:carefit_ai/screens/home_screen.dart';
import 'package:carefit_ai/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final hasApiKey = await StorageService().hasApiKey();
  runApp(CareFitApp(hasApiKey: hasApiKey));
}

class CareFitApp extends StatelessWidget {
  final bool hasApiKey;
  const CareFitApp({super.key, required this.hasApiKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareFit AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: hasApiKey ? const HomeScreen() : const OnboardingScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/core/constants/app_constants.dart';
import 'package:shopora/core/theme/app_theme.dart';
import 'package:shopora/features/auth/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase with platform-specific options or default options
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization warning: $e. Running in offline/demo mode.');
  }

  runApp(
    const ProviderScope(
      child: ShoporaApp(),
    ),
  );
}

class ShoporaApp extends StatelessWidget {
  const ShoporaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}

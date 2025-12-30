import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization failed (expected until configured): $e");
  }
  runApp(const CivilDefenseApp());
}

class CivilDefenseApp extends StatelessWidget {
  const CivilDefenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Civil Defense DGPC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB71C1C), // Civil Defense Red
          primary: const Color(0xFFB71C1C),
          secondary: const Color(0xFF0D47A1), // Civil Defense Blue
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB71C1C),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB71C1C),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      // Arabic RTL Configuration
      locale: const Locale('ar', ''),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // Arabic
        Locale('en', ''), // English
      ],
      home: const HomeScreen(),
    );
  }
}

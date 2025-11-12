import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:num_convert/screens/all_conversions_screen.dart';
import 'package:num_convert/screens/history_screen.dart';
import 'package:num_convert/screens/home_screen.dart';
import 'package:num_convert/screens/settings_screen.dart';
import 'package:num_convert/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const NumConvertApp());
}

class NumConvertApp extends StatefulWidget {
  const NumConvertApp({super.key});

  @override
  State<NumConvertApp> createState() => _NumConvertAppState();
}

class _NumConvertAppState extends State<NumConvertApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() => isDarkMode = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumConvert - Base Converter',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      routes: {
        '/': (_) => HomeScreen(onThemeChanged: toggleTheme),
        '/history': (_) => const HistoryScreen(),
        '/all': (_) => const AllConversionsScreen(),
        '/settings': (_) => SettingsScreen(onThemeChanged: toggleTheme),
      },
    );
  }
}

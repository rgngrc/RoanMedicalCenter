import 'package:flutter/material.dart';
import 'theme/themecolors.dart';
import 'pages/homepage.dart';
import 'pages/appointmentpage.dart';

void main() {
  runApp(const HospitalWebApp());
}

class HospitalWebApp extends StatelessWidget {
  const HospitalWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roan Medical Center",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ThemeColors.primary,
        colorScheme: ColorScheme.light(
          primary: ThemeColors.secondary,
          secondary: ThemeColors.accent,
          onPrimary: ThemeColors.textLight,
          onSurface: ThemeColors.textDark,
        ),
        textTheme: Typography.blackMountainView.apply(
          bodyColor: ThemeColors.textDark,
          displayColor: ThemeColors.textDark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/appointment': (context) => const AppointmentPage(),
      },
    );
  }
}

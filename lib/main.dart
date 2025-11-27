import 'package:flutter/material.dart';
import 'package:hospital/pages/loginpage.dart';
import 'package:hospital/pages/signuppage.dart';
import 'theme/themecolors.dart';
import 'pages/homepage.dart';
import 'pages/appointmentpage.dart';
import 'pages/laboratoryresultpage.dart';
import 'pages/patientportaldashboard.dart';
// import 'pages/aboutuspage.dart';
import 'pages/servicespage.dart';
import 'pages/doctorspage.dart';

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
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        // '/about': (context) => const AboutUsPage(),
        '/services': (context) => const ServicesPage(),
        '/doctors': (context) => const DoctorsPage(),
        // '/contactus': (context) => const ContactUsPage(),
        '/appointment': (context) => const AppointmentPage(),
        '/viewresults': (context) => const LaboratoryResultPage(),
        '/patientdashboard': (context) => const PatientDashboard(),
      },
    );
  }
}

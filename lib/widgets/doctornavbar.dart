// lib/widgets/doctornavbar.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';

class DoctorNavBar extends StatelessWidget {
  const DoctorNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: ThemeColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/logos/logo.png', height: 50),
              const SizedBox(width: 10),
              const Text(
                "Roan Medical Center | Doctor Dashboard",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.secondary,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Logout
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.accentDark,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Logout",
              style: TextStyle(color: ThemeColors.textLight, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

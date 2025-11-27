// lib/pages/patientportaldashboard.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import '../widgets/portalnavbar.dart';
import '../widgets/responsive.dart';
import 'laboratoryresultpage.dart';
import 'appointmentpage.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        color: ThemeColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          "Patient Portal",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ThemeColors.textDark,
          ),
        ),
      ),
    );
  }
}

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PortalNavBar(),

            const HeroSection(),

            const SizedBox(height: 20),

            // Dashboard Cards Section
            Padding(
              padding: const EdgeInsets.all(40),
              child: Responsive(
                desktop: _DashboardCardsDesktop(),
                mobile: _DashboardCardsMobile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(30),
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: ThemeColors.accent),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Desktop layout
class _DashboardCardsDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _DashboardCard(
            title: "Laboratory Results",
            icon: Icons.science_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LaboratoryResultPage(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _DashboardCard(
            title: "Appointments",
            icon: Icons.calendar_today_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentPage(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Mobile layout
class _DashboardCardsMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DashboardCard(
          title: "Laboratory Results",
          icon: Icons.science_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LaboratoryResultPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        _DashboardCard(
          title: "Appointments",
          icon: Icons.calendar_today_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppointmentPage()),
            );
          },
        ),
      ],
    );
  }
}

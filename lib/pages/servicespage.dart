import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../theme/themecolors.dart';
import '../widgets/responsive.dart';
import '../widgets/footer.dart';

const List<Map<String, dynamic>> _services = [
  {
    'title': 'General Medicine',
    'icon': Icons.local_hospital_outlined,
    'color': ThemeColors.accent,
  },
  {
    'title': 'Pediatrics',
    'icon': Icons.child_care_outlined,
    'color': ThemeColors.secondary,
  },
  {
    'title': 'Cardiology',
    'icon': Icons.favorite_outline,
    'color': ThemeColors.accentDark,
  },
  {
    'title': 'Emergency Care',
    'icon': Icons.warning_amber_outlined,
    'color': ThemeColors.secondaryDark,
  },
  {
    'title': 'Laboratory',
    'icon': Icons.science_outlined,
    'color': ThemeColors.accent,
  },
  {
    'title': 'Dermatology',
    'icon': Icons.healing_outlined,
    'color': ThemeColors.secondary,
  },
  {
    'title': 'Orthopedics',
    'icon': Icons.accessibility_new_outlined,
    'color': ThemeColors.accentDark,
  },
  {
    'title': 'Radiology',
    'icon': Icons.radio_outlined,
    'color': ThemeColors.secondaryDark,
  },
];

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: ThemeColors.secondary,
      child: const Center(
        child: Text(
          "Our Services",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: ThemeColors.textLight,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 1,
                color: ThemeColors.secondaryDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            const HeroSection(),

            _ServicesContent(),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _ServicesContent extends StatelessWidget {
  Widget _serviceCard(String title, IconData icon, Color color) {
    return ServiceCard(title: title, icon: icon, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Responsive(
        desktop: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 columns on desktop
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: 1.1,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            return _serviceCard(
              service['title'],
              service['icon'],
              service['color'],
            );
          },
        ),
        mobile: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns on mobile
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.1,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            return _serviceCard(
              service['title'],
              service['icon'],
              service['color'],
            );
          },
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      color: color.withOpacity(0.85),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 50, color: ThemeColors.textLight),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ThemeColors.textLight,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

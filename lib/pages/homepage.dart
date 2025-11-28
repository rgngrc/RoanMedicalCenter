// lib/pages/homepage.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import '../widgets/navbar.dart';
import '../widgets/responsive.dart';
import '../widgets/footer.dart';
import '../utils/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const NavBar(),

            const HeroSection(),

            const ServicesOverviewSection(),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/hero.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.1),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Responsive(
                desktop: _HeroContentDesktop(),
                mobile: _HeroContentMobile(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroContentDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Welcome to Roan Medical Center",
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: ThemeColors.textLight,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your trusted partner in health and wellness. Experience compassionate care and world-class expertise right here.",
                style: TextStyle(fontSize: 20, color: ThemeColors.textLight),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  if (Auth.isLoggedIn && Auth.userType == "patient") {
                    // Navigate to patient dashboard
                    Navigator.of(context).pushNamed('/patientdashboard');
                  } else {
                    // If not logged in or not a patient go to login page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "You must login as a patient to access the portal",
                        ),
                      ),
                    );
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.accentDark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 25,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text(
                  "Patient Portal",
                  style: TextStyle(fontSize: 20, color: ThemeColors.textLight),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroContentMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Title heading
        const Text(
          "Welcome to Roan Medical Center",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: ThemeColors.textLight,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 15),

        // Subtitle / subheading
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Your trusted partner in health and wellness. Experience compassionate care and world-class expertise right here.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: ThemeColors.textLight),
          ),
        ),
        const SizedBox(height: 30),

        // Button for patient portal
        ElevatedButton(
          onPressed: () {
            if (Auth.isLoggedIn && Auth.userType == "patient") {
              // Navigate to patient dashboard
              Navigator.of(context).pushNamed('/patientdashboard');
            } else {
              // If not logged in or not a patient go to login page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "You must login as a patient to access the portal",
                  ),
                ),
              );
              Navigator.of(context).pushNamed('/login');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.accentDark,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: const Text(
            "Patient Portal",
            style: TextStyle(
              fontSize: 18,
              color: ThemeColors.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class ServicesOverviewSection extends StatelessWidget {
  const ServicesOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: <Widget>[
          const Text(
            "Our Key Services",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: ThemeColors.textDark,
            ),
          ),
          const SizedBox(height: 40),
          Responsive(
            desktop: _ServiceGridDesktop(),
            mobile: _ServiceGridMobile(),
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 60, color: color),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceGridDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      childAspectRatio: 1.5,
      children: <Widget>[
        const ServicesOverviewSection()._serviceCard(
          'Emergency Care',
          Icons.local_hospital_outlined,
          ThemeColors.accent,
        ),
        const ServicesOverviewSection()._serviceCard(
          'Find a Specialist',
          Icons.person_search_outlined,
          ThemeColors.secondary,
        ),
        const ServicesOverviewSection()._serviceCard(
          'Request a Test',
          Icons.science_outlined,
          ThemeColors.accent,
        ),
      ],
    );
  }
}

class _ServiceGridMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.5,
      children: <Widget>[
        const ServicesOverviewSection()._serviceCard(
          'Emergency Care',
          Icons.local_hospital_outlined,
          ThemeColors.accent,
        ),
        const ServicesOverviewSection()._serviceCard(
          'Find a Specialist',
          Icons.person_search_outlined,
          ThemeColors.secondary,
        ),
        const ServicesOverviewSection()._serviceCard(
          'Request a Test',
          Icons.science_outlined,
          ThemeColors.accent,
        ),
      ],
    );
  }
}

// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import 'responsive.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(desktop: _DesktopNavbar(), mobile: _MobileNavbar());
  }
}

// Nav Links
class _DesktopNavLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _navLink('Home', context),
        _navLink('About Us', context),
        _navLink('Services', context),
        _navLink('Login', context),
        const SizedBox(width: 20),

        // Button in Navbar → now navigates to AppointmentPage
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/appointment'); // ✅ navigate
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.accentDark,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Book Appointment',
            style: TextStyle(color: ThemeColors.textLight, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

// Desktop Layout
class _DesktopNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Left Side
          _HospitalLogo(),

          // Right Side
          _DesktopNavLinks(),
        ],
      ),
    );
  }
}

// Mobile Layout
class _MobileNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Left Side
          _HospitalLogo(),

          // Right Side
          IconButton(
            icon: const Icon(Icons.menu, color: ThemeColors.textDark),
            iconSize: 30,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Home'),
                        onTap: () => Navigator.of(context).pushNamed('/'),
                      ),
                      ListTile(
                        title: const Text('Book Appointment'),
                        onTap: () =>
                            Navigator.of(context).pushNamed('/appointment'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// Hospital Logo/Name Widget
class _HospitalLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Logo
        Image.asset('assets/logos/logo.png', height: 50),

        const SizedBox(width: 10),

        // Name
        const Text(
          "Roan Medical Center",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: ThemeColors.secondaryDark,
          ),
        ),
      ],
    );
  }
}

// Helper function for nav links
Widget _navLink(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextButton(
      onPressed: () {
        if (title == 'Home') {
          Navigator.of(context).pushNamed('/');
        }
        // other routes go here
      },
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: ThemeColors.textDark,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    ),
  );
}

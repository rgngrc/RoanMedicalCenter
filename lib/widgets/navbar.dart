// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import 'responsive.dart';
import '../utils/auth.dart';

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
        _navLink('Login', context),
        _navLink('About Us', context),
        _navLink('Our Services', context),
        _navLink('Our Doctors', context),
        _navLink('Contact Us', context),
        const SizedBox(width: 10),

        ElevatedButton(
          onPressed: () {
            if (Auth.isLoggedIn && Auth.userType == "patient") {
              Navigator.of(context).pushNamed('/appointment');
            } else if (Auth.isLoggedIn && Auth.userType != "patient") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Only patients can book appointments"),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please login first to book an appointment"),
                ),
              );
            }
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_HospitalLogo(), _DesktopNavLinks()],
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
          _HospitalLogo(),
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
                        title: const Text('Login'),
                        onTap: () => Navigator.of(context).pushNamed('/login'),
                      ),
                      ListTile(
                        title: const Text('About Us'),
                        onTap: () => Navigator.of(context).pushNamed('/about'),
                      ),
                      ListTile(
                        title: const Text('Our Services'),
                        onTap: () =>
                            Navigator.of(context).pushNamed('/services'),
                      ),
                      ListTile(
                        title: const Text('Our Doctors'),
                        onTap: () =>
                            Navigator.of(context).pushNamed('/doctors'),
                      ),
                      ListTile(
                        title: const Text('Book Appointment'),
                        onTap: () {
                          if (Auth.isLoggedIn && Auth.userType == "patient") {
                            Navigator.of(context).pushNamed('/appointment');
                          } else if (Auth.isLoggedIn &&
                              Auth.userType != "patient") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Only patients can book appointments",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please login first to book an appointment",
                                ),
                              ),
                            );
                          }
                        },
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

// Hospital Logo/Name
class _HospitalLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/logos/logo.png', height: 50),
        const SizedBox(width: 10),
        const Text(
          "Roan Medical Center",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ThemeColors.secondary,
          ),
        ),
      ],
    );
  }
}

String _getRoute(String title) {
  switch (title) {
    case 'Home':
      return '/';
    case 'Login':
      return '/login';
    case 'About Us':
      return '/about';
    case 'Our Services':
      return '/services';
    case 'Our Doctors':
      return '/doctors';
    case 'Contact Us':
      return '/contact';
    case 'Book Appointment':
      return '/appointment';
    default:
      return '/';
  }
}

Widget _navLink(String title, BuildContext context) {
  final route = _getRoute(title);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(route);
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

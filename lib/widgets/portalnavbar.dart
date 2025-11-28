// lib/widgets/portalnavbar.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import '../widgets/responsive.dart';
import '../pages/appointmentpage.dart';
import '../pages/laboratoryresultpage.dart';
import '../utils/auth.dart';

class PortalNavBar extends StatelessWidget {
  const PortalNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: _DesktopPortalNavBar(),
      mobile: _MobilePortalNavBar(),
    );
  }
}

// Desktop Links (Includes View Results, Book Appointment, and Logout)
class _DesktopPortalNavLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Logout
        ElevatedButton(
          onPressed: () {
            Auth.logout(); // clear session/auth state
            Navigator.popUntil(
              context,
              (route) => route.isFirst,
            ); // go back to home/login
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Logged out successfully")),
            );
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
    );
  }
}

// Desktop Layout
class _DesktopPortalNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Image.asset('assets/logos/logo.png', height: 50),
                const SizedBox(width: 10),
                const Text(
                  "Roan Medical Center | Patient Portal",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          _DesktopPortalNavLinks(),
        ],
      ),
    );
  }
}

// Mobile Layout
class _MobilePortalNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Ensure white background
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Image.asset('assets/logos/logo.png', height: 40),
                const SizedBox(width: 8),
                const Text(
                  "Roan Medical Center",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: ThemeColors.secondary,
            ), // Visible icon
            iconSize: 30,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    color: ThemeColors.secondary,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // View Results for Mobile
                        ListTile(
                          leading: const Icon(
                            Icons.science_outlined,
                            color: ThemeColors.textLight,
                          ),
                          title: const Text(
                            "View Results",
                            style: TextStyle(color: ThemeColors.textLight),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LaboratoryResultPage(),
                              ),
                            );
                          },
                        ),
                        // Book Appointment for Mobile
                        ListTile(
                          leading: const Icon(
                            Icons.calendar_today_outlined,
                            color: ThemeColors.textLight,
                          ),
                          title: const Text(
                            "Book Appointment",
                            style: TextStyle(color: ThemeColors.textLight),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentPage(),
                              ),
                            );
                          },
                        ),
                        // Logout for Mobile
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: ThemeColors.textLight,
                          ),
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: ThemeColors.textLight),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Auth.logout();
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Logged out successfully"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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

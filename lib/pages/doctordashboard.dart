// lib/pages/doctor_dashboard.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import '../widgets/doctornavbar.dart';
import '../utils/auth.dart';

const Color _kSuccessColor = Color(0xFF4CAF50);
const Color _kDangerColor = Color(0xFFD32F2F);

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  // Sample appointments data
  final List<Map<String, String>> appointments = [
    {
      "patient": "Juan Dela Cruz",
      "time": "2025-11-28 09:00",
      "condition": "Flu",
      "notes": "Patient has mild fever",
      "status": "Pending",
    },
    {
      "patient": "Maria Santos",
      "time": "2025-11-28 10:30",
      "condition": "Check-up",
      "notes": "Routine annual check-up",
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Restrict access to doctors only
    if (!Auth.isLoggedIn || Auth.userType != "doctor") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.popUntil(context, (route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Only doctors can access this page")),
        );
      });
    }

    return Scaffold(
      backgroundColor: ThemeColors.primary,
      body: Column(
        children: [
          const DoctorNavBar(),

          const SizedBox(height: 20),

          const HeroSection(),

          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _appointmentsTab(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentsTab() {
    if (appointments.isEmpty) {
      return const Center(child: Text("No appointments available"));
    }

    return Column(
      children: appointments.map((app) {
        final patient = app["patient"] ?? "Unknown";
        final isPending = app["status"] == "Pending";

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.calendar_today_outlined,
                    color: ThemeColors.accent,
                  ),
                  title: Text(app["patient"] ?? "Unknown"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("Appointment: ${app["time"] ?? "Not set"}"),
                      Text("Condition: ${app["condition"] ?? "No condition"}"),
                      Text("Notes: ${app["notes"] ?? "No notes"}"),
                      Text(
                        "Status: ${app["status"] ?? "Pending"}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: app["status"] == "Approved"
                              ? _kSuccessColor
                              : app["status"] == "Declined"
                              ? _kDangerColor
                              : ThemeColors.secondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Approve Button
                    ElevatedButton(
                      onPressed: isPending
                          ? () {
                              setState(() {
                                app["status"] = "Approved";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "$patient appointment approved",
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kSuccessColor,
                        foregroundColor: ThemeColors.textLight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      child: const Text(
                        "Approve",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Decline Button
                    ElevatedButton(
                      onPressed: isPending
                          ? () {
                              setState(() {
                                app["status"] = "Declined";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "$patient appointment declined",
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kDangerColor,
                        foregroundColor: ThemeColors.textLight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      child: const Text(
                        "Decline",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Hero section
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
          "Doctor Dashboard",
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

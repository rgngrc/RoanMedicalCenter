// lib/pages/laboratory_result_page.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import '../widgets/portalnavbar.dart';
import '../widgets/responsive.dart';

class LaboratoryResultPage extends StatelessWidget {
  const LaboratoryResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const PortalNavBar(),

            const HeroSection(),

            const LaboratoryResultsSection(),
          ],
        ),
      ),
    );
  }
}

// Hero Section
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
          "Laboratory Result",
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

// Laboratory Results Section
class LaboratoryResultsSection extends StatelessWidget {
  const LaboratoryResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: Column(
        children: <Widget>[
          Text(
            "Here are your latest laboratory results.",
            style: TextStyle(fontSize: 20, color: ThemeColors.secondary),
          ),
          const SizedBox(height: 40),

          // Responsive Tables
          Responsive(desktop: _TablesDesktop(), mobile: _TablesMobile()),
        ],
      ),
    );
  }
}

Widget labTable(String title, List<List<String>> rowsData, String Date) {
  return Card(
    elevation: 3,
    color: ThemeColors.accentDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ThemeColors.textDark,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("TEST")),
                DataColumn(label: Text("RESULT")),
                DataColumn(label: Text("NORMAL VALUE")),
              ],
              rows: rowsData
                  .map(
                    (row) => DataRow(
                      cells: row.map((cell) => DataCell(Text(cell))).toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    ),
  );
}

class _TablesDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600), // max width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            labTable("HEMATOLOGY", [
              ["Hemoglobin", "116", "M:137-175 F:112-157"],
              ["Hematocrit", "0.38", "M:0.41-0.51 F:0.34-0.45"],
              ["RBC Ct", "4.85", "M:4.6-6.1 F:3.9-5.2"],
              ["WBC Ct", "8.6", "M:4.2-9.1 F:4.0-10.0"],
              ["Platelet Count", "456", "160-370 x10 u/L"],
            ], "DATE: November 12, 2025"),
            const SizedBox(height: 30),
            labTable("URINALYSIS", [
              ["Color", "Yellow", "Yellow"],
              ["Appearance", "Clear", "Clear"],
              ["pH", "6.0", "4.5-8.0"],
              ["Protein", "Negative", "Negative"],
              ["Glucose", "Negative", "Negative"],
              ["Ketones", "Negative", "Negative"],
            ], "DATE: November 12, 2025"),
          ],
        ),
      ),
    );
  }
}

// Mobile version: two tables stacked
class _TablesMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        labTable("HEMATOLOGY", [
          ["Hemoglobin", "116", "M:137-175 F:112-157"],
          ["Hematocrit", "0.38", "M:0.41-0.51 F:0.34-0.45"],
          ["RBC Ct", "4.85", "M:4.6-6.1 F:3.9-5.2"],
          ["WBC Ct", "8.6", "M:4.2-9.1 F:4.0-10.0"],
          ["Platelet Count", "456", "160-370 x10 u/L"],
        ], "DATE: November 12, 2025"),
        const SizedBox(height: 20),
        labTable("URINALYSIS", [
          ["Color", "Yellow", "Yellow"],
          ["Appearance", "Clear", "Clear"],
          ["pH", "6.0", "4.5-8.0"],
          ["Protein", "Negative", "Negative"],
          ["Glucose", "Negative", "Negative"],
          ["Ketones", "Negative", "Negative"],
        ], "DATE: November 12, 2025"),
      ],
    );
  }
}

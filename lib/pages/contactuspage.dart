// lib/pages/contactus.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  static const String routeName = '/contactus';

  const ContactUsPage({super.key});

  Future<void> _launchExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            _buildHeader(context),
            _buildBody(context),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: ThemeColors.secondary,
      child: const Center(
        child: Text(
          "Contact Us",
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

  Widget _buildBody(BuildContext context) {
    const double kBreakpoint = 800.0;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        padding: const EdgeInsets.all(40.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isDesktop = constraints.maxWidth > kBreakpoint;

            return isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: _GetInTouchSection()),
                      const SizedBox(width: 80),
                      Expanded(child: _buildContactDetailsSection()),
                    ],
                  )
                : Column(
                    children: [
                      const _GetInTouchSection(),
                      const SizedBox(height: 40),
                      _buildContactDetailsSection(),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _buildContactDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTACT DETAILS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ThemeColors.secondaryDark,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'To find out more about Roan Medical Center, please visit our hospital at National Highway, Cabuyao City, Laguna.',
          style: TextStyle(fontSize: 14, color: ThemeColors.textDark),
        ),
        const SizedBox(height: 20),

        // Telephone No.
        _buildContactInfoRow(
          icon: Icons.phone, // Telephone Icon
          value: '(049) 534-4026 loc. 100',
        ),

        // Cellphone No.
        _buildContactInfoRow(
          icon: Icons.smartphone, // Smartphone Icon
          value: '0998-551-7216',
        ),

        // Email Address
        _buildContactInfoRow(
          icon: Icons.mail_outline, // Mail icon
          value: 'info@roanmedical.com',
        ),

        // Address
        _buildContactInfoRow(
          icon: Icons.location_on, // Location icon
          value: 'National Highway, Calamba City, Laguna 4025',
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            _buildSocialIcon(
              Icons.facebook,
              const Color(0xFF1565C0),
              "https://www.facebook.com/",
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              Icons.camera_alt,
              const Color(0xFFE1306C),
              "https://www.instagram.com/",
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              Icons.alternate_email,
              const Color(0xFF1DA1F2),
              "https://twitter.com/",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfoRow({required IconData icon, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: ThemeColors.secondary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: ThemeColors.textDark,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Social Media Icon Button
  Widget _buildSocialIcon(IconData icon, Color color, String url) {
    return GestureDetector(
      onTap: () => _launchExternal(url),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, color: ThemeColors.textLight, size: 18),
      ),
    );
  }
}

// -Get in touch form
class _GetInTouchSection extends StatelessWidget {
  const _GetInTouchSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SEND US A MESSAGE',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ThemeColors.secondaryDark,
          ),
        ),
        const SizedBox(height: 20),
        // First Name & Last Name
        const Row(
          children: [
            Expanded(child: _ContactTextField(hintText: 'First Name*')),
            SizedBox(width: 15),
            Expanded(child: _ContactTextField(hintText: 'Last Name*')),
          ],
        ),
        const SizedBox(height: 15),
        // Email Address & Phone Number
        const Row(
          children: [
            Expanded(child: _ContactTextField(hintText: 'Email Address*')),
            SizedBox(width: 15),
            Expanded(child: _ContactTextField(hintText: 'Phone Number*')),
          ],
        ),
        const SizedBox(height: 15),
        // Message
        const _ContactTextField(hintText: 'Message*', maxLines: 7),
        const SizedBox(height: 20),
        // Submit Button
        ElevatedButton(
          onPressed: () {
            // Handle form submission
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Message sent successfully!")),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.secondaryDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(
            'SUBMIT',
            style: TextStyle(fontSize: 16, color: ThemeColors.textLight),
          ),
        ),
      ],
    );
  }
}

class _ContactTextField extends StatelessWidget {
  final String hintText;
  final int maxLines;

  const _ContactTextField({required this.hintText, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxLines == 1 ? 50 : null,
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColors.secondaryDark,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

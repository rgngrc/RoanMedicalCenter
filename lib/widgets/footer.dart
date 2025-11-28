import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/themecolors.dart';
import 'responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openRoute(BuildContext context, String routeName) {
    try {
      Navigator.of(context).pushNamed(routeName);
    } catch (e) {
      print('Navigation error: $e');
    }
  }

  Widget _buildSocialIcon(String url, Color color, IconData icon) {
    return GestureDetector(
      onTap: () => _launchExternal(url),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildSocialIconsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(
          "https://www.facebook.com/",
          const Color(0xFF1565C0),
          Icons.facebook,
        ),
        const SizedBox(width: 12),
        _buildSocialIcon(
          "https://www.instagram.com/",
          const Color(0xFFE1306C),
          Icons.camera_alt,
        ),
        const SizedBox(width: 12),
        _buildSocialIcon(
          "https://twitter.com/",
          const Color(0xFF1DA1F2),
          Icons.alternate_email,
        ),
      ],
    );
  }

  Widget _buildLogoAndTitleRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: ThemeColors.accentDark, width: 2),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/logos/logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(width: 12),
        const Text(
          "Roan Medical Center",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
            color: ThemeColors.textLight,
          ),
        ),
      ],
    );
  }

  Widget _buildContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "CONTACT DETAILS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: ThemeColors.textLight,
          ),
        ),
        const SizedBox(height: 8),
        // Contact rows
        Row(
          children: const [
            Icon(Icons.smartphone, color: ThemeColors.textLight),
            SizedBox(width: 8),
            Text(
              "0998-551-7216",
              style: TextStyle(color: ThemeColors.textLight, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: const [
            Icon(Icons.call, color: ThemeColors.textLight),
            SizedBox(width: 8),
            Text(
              "(02) 8424-3990",
              style: TextStyle(color: ThemeColors.textLight, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: const [
            Icon(Icons.email, color: ThemeColors.textLight),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "info@roanmedical.com",
                style: TextStyle(color: ThemeColors.textLight, fontSize: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBranches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "OUR BRANCHES",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: ThemeColors.textLight,
          ),
        ),
        SizedBox(height: 10),
        // Manila branch
        Text(
          "Manila, Philippines",
          style: TextStyle(
            color: ThemeColors.textLight,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 3),
        Text(
          "123 Sampaloc Avenue, Manila",
          style: TextStyle(color: ThemeColors.textLight, fontSize: 15),
        ),
        SizedBox(height: 12),
        // Laguna branch
        Text(
          "Laguna, Philippines",
          style: TextStyle(
            color: ThemeColors.textLight,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 3),
        Text(
          "45 National Highway, Calamba City",
          style: TextStyle(color: ThemeColors.textLight, fontSize: 15),
        ),
        SizedBox(height: 12),
        // Cebu branch
        Text(
          "Cebu, Philippines",
          style: TextStyle(
            color: ThemeColors.textLight,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 3),
        Text(
          "78 General Maxilom Avenue, Cebu City",
          style: TextStyle(color: ThemeColors.textLight, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "QUICK LINKS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: ThemeColors.textLight,
          ),
        ),
        const SizedBox(height: 8),
        _makeLink(context, "Home", "/"),
        _makeLink(context, "Login", "/login"),
        _makeLink(context, "Our Services", "/services"),
        _makeLink(context, "Our Doctors", "/doctors"),
        _makeLink(context, "Contact Us", "/contact"),
      ],
    );
  }

  Widget _makeLink(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => _openRoute(context, route),
        child: Text(
          text,
          style: const TextStyle(color: ThemeColors.textLight, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildLogoAndTitleRow(),
            SizedBox(width: 20),
            _buildSocialIconsRow(),
          ],
        ),

        const SizedBox(height: 30),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Contact details
            Expanded(flex: 2, child: _buildContact()),

            const Spacer(flex: 1),

            // Our branches
            Expanded(flex: 2, child: _buildBranches()),

            const Spacer(flex: 1),

            // Quick Links
            Expanded(flex: 1, child: _buildLinks(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoAndTitleRow(),

        const SizedBox(height: 15),

        _buildSocialIconsRow(),

        const SizedBox(height: 40),

        _buildContact(),

        const SizedBox(height: 40),

        _buildBranches(),

        const SizedBox(height: 40),

        _buildLinks(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth > 800 ? 80.0 : 40.0;

    return Column(
      children: [
        Container(
          color: ThemeColors.secondary,
          padding: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: horizontalPadding,
          ),

          child: Responsive(
            desktop: _buildDesktopLayout(context),
            mobile: _buildMobileLayout(context),
          ),
        ),

        // Copyright
        Container(
          color: Colors.black,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: const Center(
            child: Text(
              "© 2025 Roan Medical Center. All Rights Reserved.",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}

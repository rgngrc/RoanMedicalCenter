// lib/pages/loginpage.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import 'signuppage.dart';
import '../pages/patientportaldashboard.dart';
import '../pages/doctordashboard.dart';
import '../utils/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final int initialIndex = (args is String && args == 'signup') ? 1 : 0;

    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      appBar: AppBar(
        title: const Text('Sign in / Sign up'),
        backgroundColor: ThemeColors.secondary,
        elevation: 0,
      ),
      body: initialIndex == 0 ? const _LoginTab() : const SignupPage(),
    );
  }
}

class _LoginTab extends StatefulWidget {
  const _LoginTab();

  @override
  State<_LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<_LoginTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text;

      // Simulate authentication
      Auth.isLoggedIn = true;

      // Determine user type based on email (or your auth logic)
      if (email.contains("patient")) {
        Auth.userType = "patient";
      } else {
        Auth.userType = "doctor";
      }

      // Navigate based on role
      if (Auth.userType == "patient") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PatientDashboard()),
        );
      } else if (Auth.userType == "doctor") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DoctorDashboard()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid user type")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: ThemeColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.secondaryDark.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Login Now",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.textDark,
                  ),
                ),
                const SizedBox(height: 25),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _roundedField("Email or Username"),
                  validator: (v) =>
                      v == null || v.isEmpty ? "Email required" : null,
                ),
                const SizedBox(height: 18),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: _roundedField("Password"),
                  validator: (v) => v == null || v.length < 6
                      ? "Password must be at least 6 characters"
                      : null,
                ),
                const SizedBox(height: 25),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.accentDark,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.textLight,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "Or login with",
                  style: TextStyle(color: ThemeColors.textDark),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(Icons.facebook, "Facebook"),
                    const SizedBox(width: 12),
                    _socialButton(Icons.g_mobiledata, "Google"),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/login',
                          arguments: 'signup',
                        );
                      },
                      child: Text(
                        "Signup now",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ThemeColors.secondaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _roundedField(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: ThemeColors.accent.withOpacity(0.12),
      labelStyle: TextStyle(color: ThemeColors.textDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ThemeColors.accentDark.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ThemeColors.secondaryDark, width: 2),
      ),
    );
  }

  Widget _socialButton(IconData icon, String text) {
    return GestureDetector(
      onTap: _login,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: ThemeColors.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: ThemeColors.secondaryDark),
            const SizedBox(width: 6),
            Text(text, style: TextStyle(color: ThemeColors.textDark)),
          ],
        ),
      ),
    );
  }
}

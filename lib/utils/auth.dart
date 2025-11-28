// lib/utils/auth.dart

class Auth {
  // Simulated logged-in status
  static bool isLoggedIn = false;
  static String userType = "patient";

  // Simulated patient info
  static String? userName = "John Doe";
  static String? userEmail = "john@example.com";

  // Call this to log out
  static void logout() {
    isLoggedIn = false;
    userType = "";
    userName = null;
    userEmail = null;
  }
}

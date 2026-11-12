class DemoAuth {
  static String? registeredUsername;
  static String? registeredPassword;

  static bool login(String username, String password) {
    if (username == 'Vincent29' && password == 'lourdevincent102006') {
      return true;
    }

    if (registeredUsername != null &&
        registeredPassword != null &&
        username == registeredUsername &&
        password == registeredPassword) {
      return true;
    }

    return false;
  }

  static void register(String username, String password) {
    registeredUsername = username;
    registeredPassword = password;
  }
}

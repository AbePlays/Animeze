import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferences prefs;
  ThemeMode themeMode = ThemeMode.light;

  initTheme() async {
    prefs = await SharedPreferences.getInstance();
    getThemeDataOnStartup();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) async {
    if (isOn) {
      themeMode = ThemeMode.dark;
      await prefs.setInt('isDarkModeEnabled', 1);
    } else {
      themeMode = ThemeMode.light;
      await prefs.setInt('isDarkModeEnabled', 0);
    }
    notifyListeners();
  }

  getThemeDataOnStartup() {
    int isDarkModeEnabled = (prefs.getInt('isDarkModeEnabled') ?? 0);
    print('Is Dark Mode Enabled = $isDarkModeEnabled.');
    if (isDarkModeEnabled == 0) {
      themeMode = ThemeMode.light;
      notifyListeners();
    } else {
      themeMode = ThemeMode.dark;
      notifyListeners();
    }
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColor: Colors.white,
    accentColor: Colors.grey[800],
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    accentColor: Colors.grey[50],
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.light(),
  );
}

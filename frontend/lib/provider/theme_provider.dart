import 'package:flutter/material.dart';
import 'package:totalcare/constant/global_variables.dart';

class ThemeProvider extends ChangeNotifier {
 ThemeData _currentTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: backgroundColor,
    ),
  );

  ThemeData get currentTheme => _currentTheme;
  void setThemeColor(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _isCheckBoxChecked = false;

  Color _appBarColor1 = Color(0xFFF5CB45);
  Color _appBarColor2 = Color(0xFFF54927);
  Color _buttonGradientColor1 = Color(0xFFF5CB45);
  Color _buttonGradientColor2 = Color(0xFFF54927);
  Color _checkBoxColor = Color(0xFFF5CB45);

  bool get isDarkMode => _isDarkMode;
  bool get isCheckBoxChecked => _isCheckBoxChecked;
  Color get appBarColor1 => _appBarColor1;
  Color get appBarColor2 => _appBarColor2;
  Color get buttonColor1 => _buttonGradientColor1;
  Color get buttonColor2 => _buttonGradientColor2;
  Color get checkBoxColor => _checkBoxColor;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _appBarColor1 = _isDarkMode ? Color(0xFFB674EB) : Color(0xFFF5CB45);
    _appBarColor2 = _isDarkMode ? Color(0xFF1AEBD3) : Color(0xFFF54927);
    _buttonGradientColor1 = _isDarkMode ? Color(0xFFB674EB) : Color(0xFFF5CB45);
    _buttonGradientColor2 = _isDarkMode ? Color(0xFF1AEBD3) : Color(0xFFF54927);
    _checkBoxColor = _isDarkMode ? Color(0xFFB674EB) : Color(0xFFF54927);
    notifyListeners();
  }

  void toggleCheckBox() {
    _isCheckBoxChecked =! _isCheckBoxChecked;
    notifyListeners();
  }
}
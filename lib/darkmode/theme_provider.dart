import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _isCheckBoxChecked = false;

  Color _appBarColor1 = const Color(0xFFF5CB45);
  Color _appBarColor2 = const Color(0xFFF54927);
  Color _buttonGradientColor1 = const Color(0xFFF5CB45);
  Color _buttonGradientColor2 = const Color(0xFFF54927);
  Color _checkBoxColor = const Color.fromARGB(255, 222, 70, 40);
  Color _textColor = Colors.black;
  Color _textColor2 = const Color(0xFFF54927);
  Color _iconsColor = Colors.white;
  Color _iconsColor2 = Colors.black;

  bool get isDarkMode => _isDarkMode;
  bool get isCheckBoxChecked => _isCheckBoxChecked;
  Color get appBarColor1 => _appBarColor1;
  Color get appBarColor2 => _appBarColor2;
  Color get buttonColor1 => _buttonGradientColor1;
  Color get buttonColor2 => _buttonGradientColor2;
  Color get checkBoxColor => _checkBoxColor;
  Color get textColor => _textColor;
  Color get textColor2 => _textColor2;
  Color get iconsColor => _iconsColor;
  Color get iconsColor2 => _iconsColor2;

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> saveTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    saveTheme();
    _appBarColor1 = _isDarkMode
        ? const Color.fromARGB(255, 121, 68, 165)
        : const Color.fromARGB(255, 218, 181, 61);
    _appBarColor2 = _isDarkMode
        ? const Color.fromARGB(255, 22, 184, 165)
        : const Color.fromARGB(255, 222, 70, 40);
    _buttonGradientColor1 = _isDarkMode
        ? const Color.fromARGB(255, 121, 68, 165)
        : const Color.fromARGB(255, 218, 181, 61);
    _buttonGradientColor2 = _isDarkMode
        ? const Color.fromARGB(255, 22, 184, 165)
        : const Color.fromARGB(255, 222, 70, 40);
    _checkBoxColor = _isDarkMode
        ? const Color.fromARGB(255, 121, 68, 165)
        : const Color.fromARGB(255, 222, 70, 40);
    _textColor = _isDarkMode ? Colors.white : Colors.black;
    _textColor2 = _isDarkMode
        ? const Color.fromARGB(255, 22, 184, 165)
        : const Color(0xFFF54927);
    _iconsColor = isDarkMode ? Colors.white : Colors.white;
    _iconsColor2 = isDarkMode ? Colors.white : Colors.black;
    notifyListeners();
  }

  void toggleCheckBox() {
    _isCheckBoxChecked = !_isCheckBoxChecked;
    notifyListeners();
  }
}

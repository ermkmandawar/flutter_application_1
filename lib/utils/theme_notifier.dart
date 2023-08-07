import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier{
  late ThemeData _selectTheme;
  late SharedPreferences prefs;
  ThemeProvider({bool isDark  = false}){
    _selectTheme = isDark ? darkTheme: lightTheme;
  }
  ThemeData get getTheme =>_selectTheme;
  
  Future<void> changeTheme() async{
    prefs = await SharedPreferences.getInstance();
    
    if (_selectTheme == darkTheme){
      _selectTheme = lightTheme;
      await prefs.setBool("isDark", false);
    }
    else{
      _selectTheme = darkTheme;
      await prefs.setBool("isDark", true);
    }
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
class Themes {
  static ThemeData lightMode = ThemeData(
    backgroundColor: white,
    primaryColor: white,
    brightness: Brightness.light,
  );
  static ThemeData darkMode = ThemeData(
    backgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
TextStyle get headerStyle => GoogleFonts.lato(
  textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.grey[100] : Colors.black,
      fontWeight: FontWeight.w900,
      fontSize: 26
  ),
);

TextStyle get dateStyle => GoogleFonts.lato(
  textStyle:  TextStyle(
      color:  Colors.grey[600],
      fontWeight: FontWeight.w600,
      fontSize: 16
  ),
);
TextStyle get subHeaderStyle => GoogleFonts.lato(
  textStyle:  TextStyle(
      color:Get.isDarkMode ? Colors.grey[100] : Colors.black,
      fontWeight: FontWeight.w900,
      fontSize: 22
  ),
);
TextStyle get titleStyle => GoogleFonts.lato(
  textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.grey[300] : Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18
  ),
);
TextStyle get subTitleStyle => GoogleFonts.lato(
  textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16
  ),
);
TextStyle get bodyStyle => GoogleFonts.lato(
  textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.grey[100] : Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14
  ),
);

import 'package:flutter/material.dart';

/*
 * themes defined for simpleShare, thus defining each color, letter in the entire system
 * @author  SGV - 20220705
 * @version 1.0 - 20220705 - initial release
 */
class CebrerosStyle {
  final ThemeData theme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Noto Sans Meetei Mayek',
    primaryColor: CustomColors.backgroundColorDark,
    primaryColorDark:CustomColors.backgroundColorDark,
    colorScheme: ColorScheme.fromSwatch(errorColor:CustomColors.cancelActionButtonColor, backgroundColor: CustomColors.frontColor).copyWith(
      primary: CustomColors.backgroundColorDark,
      secondary: CustomColors.backgroundColorDark,
    ),
    dialogBackgroundColor: CustomColors.frontColor,
    dividerColor: CustomColors.backgroundColorDark,
    disabledColor:  CustomColors.backgroundColorDark,
    iconTheme: IconThemeData(color: CustomColors.backgroundColorDark),
  
  );
}

class CustomColors {
  static Color pantone5615 = Color.fromRGBO((255 * (1 - 0.65) * (1 - 0.24)).round(),(255 * (1 - 0.36) * (1 - 0.24)).round(), (255 * (1 - 0.56) * (1 - 0.24)).round(), 1.0);
  static Color backgroundColorDark = Colors.black;
  static Color frontColor = Colors.white;
  static Color activeButtonColor = Colors.green;
  static Color backgroundColorInput = Colors.grey;
  static Color cancelActionButtonColor = Colors.red;
  static Color tableColor = const Color(0xffd1d0ce);
  static Color tableColor2 = const Color(0xffc4bcb1);
  static Color tableColor3 = const Color(0xffd9d6cf);
  static Color tableColor4 = const Color(0xfff7f6f4);
  static Color displayColor = const Color(0xffefeff4);
  static Color pantone720 = const Color(0xff8c573a);
  static Color kSecondaryColor =const Color(0xFFfe5722); //secondary color
 

}

class TextThemeCustom {
  static textButtom({Color? color = Colors.black87}) {
    return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1);
  }
}
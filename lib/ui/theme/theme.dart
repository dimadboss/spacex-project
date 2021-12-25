import 'package:flutter/material.dart';

import 'colors/light_color.dart';

enum ThemeType { LIGHT }

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData.light().copyWith(
      backgroundColor: LightColor.background,
      primaryColor: LightColor.primaryColor,
      cardTheme: CardTheme(color: LightColor.background),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.bottomAppBarColor,
      dividerColor: LightColor.grey,
      cardColor: LightColor.primaryExtraLightColor,
      appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: LightColor.primaryColor,
          iconTheme: IconThemeData(color: LightColor.background)),
      disabledColor: LightColor.grey,
      primaryTextTheme: TextTheme(
          bodyText1: TextStyle(
        color: LightColor.titleTextColor,
      )),
      brightness: Brightness.light,
      tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.symmetric(vertical: 16),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: LightColor.buttonColor,
        disabledColor: LightColor.disableButtonColor,
        textTheme: ButtonTextTheme.normal,
      ),
      primaryIconTheme: IconThemeData(color: LightColor.secondaryColor),
      colorScheme: ColorScheme(
          primary: LightColor.primaryColor,
          primaryVariant: LightColor.primaryLightColor,
          secondary: LightColor.secondaryColor,
          secondaryVariant: LightColor.secondaryLightColor,
          surface: LightColor.background,
          background: LightColor.background,
          error: Colors.red,
          onPrimary: LightColor.onBackground,
          onSecondary: LightColor.black,
          onSurface: LightColor.titleTextColor,
          onBackground: LightColor.titleTextColor,
          onError: LightColor.titleTextColor,
          brightness: Brightness.dark),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: LightColor.titleTextColor),
        subtitle1: TextStyle(
          color: LightColor.subTitleTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
          textStyle: TextStyle(
            fontSize: 20,
            color: LightColor.titleTextColor,
          ),
          color: LightColor.background));

  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 16,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static ThemeData getThemeFromKey(ThemeType themeKey) {
    return lightTheme;
  }
}

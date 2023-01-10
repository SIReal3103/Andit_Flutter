import 'package:andit/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      backgroundColor: ColorConstant.backgroundColorLight,
      brightness: Brightness.light,
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        iconTheme: IconThemeData(color: ColorConstant.iconColorLight),
        elevation: 0,
        foregroundColor: ColorConstant.textColorLight,
        backgroundColor: ColorConstant.backgroundColorLight,
      ),
      primaryColor: ColorConstant.primaryColor,
      cardColor: ColorConstant.secondaryBackgroundColorLight,
      iconTheme: ThemeData.light().iconTheme.copyWith(
        color: ColorConstant.iconColorLight,
      ),
      dividerTheme: ThemeData.light().dividerTheme.copyWith(
        color: ColorConstant.dividerColorLight,
        thickness: 1,
      ),
      dividerColor: ColorConstant.dividerColorLight,
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(primary: ColorConstant.primaryColor));

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      backgroundColor: ColorConstant.backgroundColorDark,
      appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        iconTheme: IconThemeData(color: ColorConstant.iconColorDark),
        foregroundColor: ColorConstant.textColorDark,
        backgroundColor: ColorConstant.backgroundColorDark,
        elevation: 0,
      ),
      primaryColor: ColorConstant.primaryColor,
      cardColor: ColorConstant.secondaryBackgroundColorDark,
      iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: ColorConstant.iconColorDark,
      ),
      dividerTheme: ThemeData.dark().dividerTheme.copyWith(
        color: ColorConstant.dividerColorLight,
        thickness: 1,
      ),
      dividerColor: ColorConstant.dividerColorDark,
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(primary: ColorConstant.primaryColor));
}


//
//
// Custom Dark theme


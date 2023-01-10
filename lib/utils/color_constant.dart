import 'package:flutter/material.dart';

class ColorConstant {
  // Old version color (The colors below are being using in project. If you want to
  // remove those, Please refactor the code that includes them before)
  static const Color yellowBackgroundColor = Color(0xffFDF6D9);
  static const Color lightGreyColor = Color.fromARGB(230, 150, 153, 156);
  static const Color sliderColor = Color.fromARGB(255, 189, 193, 198);
  static const Color textFieldHeadingColor = Color.fromARGB(255, 75, 65, 67);
  static const Color lighterGreyColor = Color(0xffD8DBE0);
  static const Color lightGreyColorAlpha40 = Color(0x66d8dbe0);
  static const Color white = Color(0xffffffff);
  static const Color backgroundPoolItem = Color(0xfffafafa);
  static const Color grey50 = Color(0x808e8989);

  // New version Color

  // Common color
  static const Color primaryColor = Color(0xffFBAB18);
  static const Color lightPrimaryColor = Color(0xffE8BB41);
  static const Color primaryButtonTextColor = Color(0xff181e20);

  // status color

  static const Color positiveColorLight = Color(0xff2EBD84);
  static const Color positiveColorDark = Color(0xff2EBD84);

  static Color positiveBackgroundColorLight =
      positiveColorLight.withOpacity(0.3);
  static Color positiveBackgroundColorDark = positiveColorDark.withOpacity(0.3);

  static const Color negativeColorLight = Color(0xffFB445F);
  static const Color negativeColorDark = Color(0xffF5455D);

  static Color negativeBackgroundColorLight =
      negativeColorLight.withOpacity(0.3);
  static Color negativeBackgroundColorDark = negativeColorDark.withOpacity(0.3);

  // text
  static const Color textColorLight = Color(0xFF1E2329);
  static const Color textColorDark = Color(0xFFEAECEF);

  static const Color secondaryTextColorLight = Color(0xff707A8A);
  static const Color secondaryTextColorDark = Color(0xff848E8C);

  // background
  static const Color backgroundColorLight = Color(0xffffffff);
  static const Color backgroundColorDark = Color(0xFF1f2630);

  static const Color layoutBackgroundColorLight = Color(0xfff5f5f5);
  static const Color layoutBackgroundColorDark = Color(0xFF171e26);

  static const Color secondaryBackgroundColorLight = Color(0xFFfafafa);
  static const Color secondaryBackgroundColorDark = Color(0xFF29313c);

  // input
  static const Color inputBackgroundColorLight = Color(0xFFf5f5f5);
  static const Color inputBackgroundColorDark = Color(0xFF29313c);

  // divider
  static const Color dividerColorLight = Color(0xffEAECEF);
  static const Color dividerColorDark = Color(0xff333b46);

  // button
  static const Color buttonBackgroundColorLight = Color(0xffEBECF0);
  static const Color buttonBackgroundColorDark = Color(0xff333b46);

  // icon
  static const Color iconColorLight = Color(0xff929AA5);
  static const Color iconColorDark = Color(0xff717a8b);

  // search bar
  static const Color searchBackgroundColorLight = Color(0xffEDEEF0);
  static const Color searchBackgroundColorDark = Color(0xff22262C);
}

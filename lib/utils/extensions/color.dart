import 'package:flutter/material.dart';
import '../color_constant.dart';

extension CustomColorScheme on ColorScheme {
  Color get positiveColor => brightness == Brightness.light
      ? ColorConstant.positiveColorLight
      : ColorConstant.positiveColorDark;
  Color get positiveBackgroundColor => brightness == Brightness.light
      ? ColorConstant.positiveBackgroundColorLight
      : ColorConstant.positiveBackgroundColorDark;
  Color get negativeColor => brightness == Brightness.light
      ? ColorConstant.negativeColorLight
      : ColorConstant.negativeColorDark;
  Color get negativeBackgroundColor => brightness == Brightness.light
      ? ColorConstant.negativeBackgroundColorLight
      : ColorConstant.negativeBackgroundColorDark;
  Color get textColor => brightness == Brightness.light
      ? ColorConstant.textColorLight
      : ColorConstant.textColorDark;
  Color get secondaryTextColor => brightness == Brightness.light
      ? ColorConstant.secondaryTextColorLight
      : ColorConstant.secondaryTextColorDark;
  Color get backgroundColor => brightness == Brightness.light
      ? ColorConstant.backgroundColorLight
      : ColorConstant.backgroundColorDark;
  Color get layoutBackgroundColor => brightness == Brightness.light
      ? ColorConstant.layoutBackgroundColorLight
      : ColorConstant.layoutBackgroundColorDark;
  Color get secondaryBackgroundColor => brightness == Brightness.light
      ? ColorConstant.secondaryBackgroundColorLight
      : ColorConstant.secondaryBackgroundColorDark;
  Color get inputBackgroundColor => brightness == Brightness.light
      ? ColorConstant.inputBackgroundColorLight
      : ColorConstant.inputBackgroundColorDark;
  Color get dividerColor => brightness == Brightness.light
      ? ColorConstant.dividerColorLight
      : ColorConstant.dividerColorDark;
  Color get buttonBackgroundColor => brightness == Brightness.light
      ? ColorConstant.buttonBackgroundColorLight
      : ColorConstant.buttonBackgroundColorDark;
  Color get iconColor => brightness == Brightness.light
      ? ColorConstant.iconColorLight
      : ColorConstant.iconColorDark;
  Color get searchBackgroundColor => brightness == Brightness.light
      ? ColorConstant.searchBackgroundColorLight
      : ColorConstant.searchBackgroundColorDark;
  Color get primaryColor => ColorConstant.primaryColor;
}

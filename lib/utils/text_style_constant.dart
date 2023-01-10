import 'package:andit/utils/color_constant.dart';
import 'package:andit/utils/size_constant.dart';
import 'package:flutter/material.dart';

class TextStyleConstant {
  // New version
  static TextStyle lg = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeLarge,
      fontWeight: FontWeight.w500);

  // old version
  static TextStyle h1 = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeLarge,
      fontWeight: FontWeight.bold);
  static TextStyle h2 = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeMedium,
      fontWeight: FontWeight.bold);
  static TextStyle sectionHeader = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeLarge,
      fontWeight: FontWeight.bold);

  static TextStyle screenTitle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeScreenTitle,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textFieldHeadingStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeMedium,
    fontWeight: FontWeight.normal,
    color: ColorConstant.textFieldHeadingColor,
  );

  static TextStyle textFieldHintStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeMedium,
    fontWeight: FontWeight.normal,
    color: ColorConstant.lightGreyColor,
  );

  static TextStyle orderFieldHint = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeLarge,
    fontWeight: FontWeight.normal,
    color: ColorConstant.lightGreyColor,
  );
  static TextStyle hintText = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeSmall,
      color: ColorConstant.lightGreyColor);
  static TextStyle boldHintText = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeSmall,
      fontWeight: FontWeight.bold,
      color: ColorConstant.lightGreyColor);
  static TextStyle textButtonStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeMedium,
    fontWeight: FontWeight.bold,
    color: ColorConstant.primaryColor,
  );
  static TextStyle body = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeSmall,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textTabActive = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeSmall,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textTabInactive = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeSmall,
    fontWeight: FontWeight.normal,
  );

  static TextStyle tabTitle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeMedium,
      fontWeight: FontWeight.w500);
  static TextStyle unselectedTabTitle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeMedium,
      fontWeight: FontWeight.w500,
      color: ColorConstant.lightGreyColor);

  static TextStyle lightTittle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: SizeConstant.fontSizeVerySmall,
      color: ColorConstant.lightGreyColor);
  static TextStyle earnTitle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeLarge,
    fontWeight: FontWeight.bold,
  );

  static TextStyle normalMediumText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeMedium,
  );
  static TextStyle normalSmallText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeSmall,
  );
  static TextStyle normalSmallxText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizexSmall,
  );
  static TextStyle normalSmallxxText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeVerySmall,
  );

  static TextStyle normalLargeText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeLarge,
  );
  static TextStyle normalLargexText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizexLarge,
  );
  static TextStyle normalLargexxText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizexxLarge,
  );
  static TextStyle normalTitleText = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeScreenTitle,
  );
  static TextStyle bodyBold = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeSmall,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyUnderlineDot = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: SizeConstant.fontSizeSmall,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dotted,
  );
}

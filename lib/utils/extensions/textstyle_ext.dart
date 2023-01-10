import 'package:andit/utils/app_config.dart';
import 'package:andit/utils/extensions/color.dart';
import 'package:andit/utils/color_constant.dart';
import 'package:flutter/material.dart';

extension ExtendedTextStyle on TextStyle {
  // define text's font weight
  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get semiBold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle get whiteTextColor {
    return copyWith(color: Colors.white);
  }

  TextStyle get blackTextColor {
    return copyWith(color: ColorConstant.textColorLight);
  }

  TextStyle get textColor {
    return copyWith(
      color: Theme.of(AppConfig().getContext).colorScheme.textColor,
    );
  }

  TextStyle get secondaryTextColor {
    return copyWith(
      color: Theme.of(AppConfig().getContext).colorScheme.secondaryTextColor,
    );
  }

  TextStyle get primaryColor {
    return copyWith(
      color: ColorConstant.primaryColor,
    );
  }

  // convenience functions
  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size);
  }
}

// How to use?
// Text('test text', style: TextStyles.normalText.semibold.whiteColor);
// Text('test text', style: TextStyles.itemText.whiteColor.bold);
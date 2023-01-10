import 'package:andit/utils/extensions/color.dart';
import 'package:andit/utils/color_constant.dart';
import 'package:andit/utils/text_style_constant.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
  danger,
  active,
  mute,
  inactive,
  none,
  grey
}

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.type = ButtonType.primary,
      this.buttonStyle})
      : super(
          key: key,
        );
  final VoidCallback onPressed;
  final Widget child;
  final ButtonType type;
  final ButtonStyle? buttonStyle;

  ButtonStyle _buttonStyle(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyleConstant.textButtonStyle
                  .merge(TextStyle(color: ColorConstant.textFieldHeadingColor)),
            ),
            foregroundColor:
                MaterialStateProperty.all<Color>(ColorConstant.textColorLight),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorConstant.primaryColor));
      case ButtonType.active:
        return ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyleConstant
                .textButtonStyle
                .merge(TextStyle(color: ColorConstant.textColorLight))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.positiveColor));
      case ButtonType.danger:
        return ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyleConstant.textButtonStyle),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.negativeColor),
          foregroundColor: MaterialStateProperty.all<Color>(
              ColorConstant.textFieldHeadingColor),
        );

      case ButtonType.secondary:
        return ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyleConstant.textButtonStyle),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.buttonBackgroundColor),
          foregroundColor:
              MaterialStateProperty.all<Color>(ColorConstant.textColorLight),
        );

      case ButtonType.mute:
        return ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyleConstant.textButtonStyle),
            foregroundColor: MaterialStateProperty.all<Color>(
                ColorConstant.primaryButtonTextColor),
            backgroundColor: MaterialStateProperty.all<Color>(
                ColorConstant.primaryButtonTextColor));
      case ButtonType.inactive:
        return ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyleConstant.textButtonStyle),
          foregroundColor:
              MaterialStateProperty.all<Color>(ColorConstant.lightGreyColor),
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorConstant.lighterGreyColor),
        );
      case ButtonType.grey:
        return ElevatedButton.styleFrom(
          primary: ColorConstant.lightGreyColor,
          onPrimary: Colors.black, //adding this would work
        );
      default:
        return buttonStyle ?? ButtonStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: _buttonStyle(context),
    );
  }
}

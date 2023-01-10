import 'package:andit/utils/color_constant.dart';
import 'package:andit/utils/extensions/textstyle_ext.dart';
import 'package:andit/utils/text_style_constant.dart';
import 'package:andit/views/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:andit/utils/extensions/color.dart';

enum task_type {
  // taskCenter,
  // rewardCenter,
  // pay,
  // giftCard,
  // myGifts,
  identification,
  security,
  settings,
  language,
  referral,
}

extension Validator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  String hideDetail() {
    return replaceRange(2, (length - 2), "******");
  }

  String captializeFirstLetter() {
    var firstChar = substring(0, 1).toUpperCase();
    var remain = substring(1).toLowerCase();
    return firstChar + remain;
  }
}

class Utils {
  static String chartURL = 'https://dev.piex.io/trading-view';
  static String futureChartURL = 'https://dev.piex.io/future-trading-view';
  static String recapchaKey = '6LcWP9weAAAAAHJwJ2fuAdac7lVk1W7a0cTQhakK';
  static String recapchaUrl = 'https://dev.piex.io/';
  static String secretKey = '1f73448682a75bf9f45e42b79e196688';
  static String socketURL = 'https://dev.piex.io/';

  static Future<String> encrypt(String content) async {
    return 'encryptText';
  }

  static showLoading() {
    if (EasyLoading.isShow) {
      return;
    }
    EasyLoading.show(status: 'Loading');
  }

  static String volString(double value) {
    var result = value / 1000;
    if (result > 1000) {
      return (result / 1000).toStringAsFixed(2) + 'B';
    }
    if (result < 1000) {
      return (result).toStringAsFixed(2) + 'M';
    }
    return value.toStringAsFixed(2);
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (currentFocus.isFirstFocus || currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static hideLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  static showErrorMessage(BuildContext context, String title, String? content) {
    var alert = AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 80,
          ),
          Text(title),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content != null ? "code_error.$content".tr() : ''),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK')),
                ),
              ),
            ],
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  static showSuccessMessage(
    BuildContext context,
    String title,
    String content,
    VoidCallback? onClose,
  ) {
    var alert = AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 80,
          ),
          Text(title),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                    onPressed: () {
                      if (onClose != null) {
                        onClose();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'ok'.tr(),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  static showComingSoon(BuildContext context) {
    var alert = AlertDialog(
      title: Column(
        children: const [
          Icon(
            Icons.construction,
            color: ColorConstant.lightGreyColor,
            size: 80,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Coming soon!'),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('ok'.tr())),
                ),
              ),
            ],
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  static showSuccessSnackbar(
      BuildContext context, String title, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.backgroundColor,
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(content,
                style: TextStyleConstant.normalMediumText.copyWith(
                  color: ColorConstant.textColorDark,
                )),
          ],
        )));
    return;
  }

  static showMessage(BuildContext context, String content) {
    var alert = AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.backgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK')),
                ),
              ),
            ],
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  static showCustomMessage(BuildContext context, Widget contentCustom) {
    var alert = AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          contentCustom,
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK')),
                ),
              ),
            ],
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  static showErrorMessageCallback(
      BuildContext context, String title, String? content,
      {VoidCallback? onClose}) {
    var alert = AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 80,
          ),
          Text(title),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content ?? ''),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onClose?.call();
                      },
                      child: Text('OK')),
                ),
              ),
            ],
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  static String taskTypeTitle(task_type taskType) {
    switch (taskType) {
      // case task_type.giftCard:
      //   return 'gift_card'.tr();
      // case task_type.myGifts:
      //   return 'my_gifts'.tr();
      // case task_type.paymentMethod:
      //   return 'payment_method'.tr();
      // case task_type.taskCenter:
      //   return 'task_center'.tr();
      // case task_type.notification:
      //   return 'Notifications'.tr();
      case task_type.identification:
        return 'identification'.tr();
      // case task_type.rewardCenter:
      //   return 'reward_center'.tr();
      // case task_type.pay:
      //   return 'pay'.tr();
      case task_type.settings:
        return 'settings'.tr();
      case task_type.security:
        return 'security'.tr();
      case task_type.language:
        return 'language'.tr();
      case task_type.referral:
        return 'Referral'.tr();
      default:
        return 'task_center'.tr();
    }
  }

  static String taskTypeScreen(task_type taskType) {
    switch (taskType) {
      // case task_type.giftCard:
      //   return 'gift_card';
      // case task_type.myGifts:
      //   return 'my_gifts';
      // case task_type.paymentMethod:
      //   return 'payment_method';
      // case task_type.taskCenter:
      //   return 'task_center';
      // case task_type.notification:
      //   return 'Notifications';
      // case task_type.rewardCenter:
      //   return 'reward_center';
      // case task_type.pay:
      //   return 'pay';
      case task_type.settings:
        return 'settings';
      case task_type.identification:
        return 'identification';
      case task_type.security:
        return 'security';
      case task_type.language:
        return 'language';
      default:
        return 'task_center';
    }
  }

  static IconData taskTypeIcon(task_type taskType) {
    switch (taskType) {
      // case task_type.giftCard:
      //   return FontAwesome5.gift;
      // case task_type.myGifts:
      //   return FontAwesome5.gifts;
      // case task_type.paymentMethod:
      //   return Icons.payment;
      // case task_type.taskCenter:
      // return Icons.task;
      // case task_type.notification:
      //   return Icons.notifications;
      // case task_type.rewardCenter:
      //   return FontAwesome5.luggage_cart;
      // case task_type.pay:
      //   return Icons.credit_card;
      case task_type.settings:
        return Icons.settings;
      case task_type.security:
        return Icons.security;
      case task_type.language:
        return Icons.language;
      case task_type.identification:
        return Icons.perm_identity;
      case task_type.referral:
        return Icons.room_preferences_outlined;
      default:
        return Icons.task;
    }
  }
}

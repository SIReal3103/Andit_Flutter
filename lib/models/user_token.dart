import 'dart:convert';
import 'package:andit/utils/extensions/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

UserToken userTokenFromJson(String str) => UserToken.fromJson(json.decode(str));

String userTokenToJson(UserToken data) => json.encode(data.toJson());

class UserToken {
  UserToken({
    required this.id,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    this.identityVerificationStatus,
    this.accessToken,
    this.refreshToken,
  });

  String id;
  String userId;
  String email;
  String phoneNumber;
  String? identityVerificationStatus;
  String? accessToken;
  String? refreshToken;

  bool isVerified() {
    return identityVerificationStatus == 'verified';
  }

  String statusHeader() {
    if (identityVerificationStatus == 'confirmed') {
      return "verify_status.verified".tr();
    } else {
      return "verify_status.notVerified".tr();
    }
  }

  Color statusHeaderColor(BuildContext context) {
    if (identityVerificationStatus == 'confirmed') {
      return Theme.of(context).colorScheme.positiveColor;
    } else {
      return Theme.of(context).colorScheme.negativeColor;
    }
  }

  factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
        id: json["id"],
        userId: json["userId"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        identityVerificationStatus: json["identityVerificationStatus"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "email": email,
        "phoneNumber": phoneNumber,
        "identityVerificationStatus": identityVerificationStatus,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

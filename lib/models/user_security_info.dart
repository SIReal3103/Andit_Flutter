// To parse this JSON data, do
//
//     final UserSecurityInfo = UserSecurityInfoFromJson(jsonString);

import 'dart:convert';

UserSecurityInfo userSecurityInfoFromJson(String str) => UserSecurityInfo.fromJson(json.decode(str));

String userSecurityInfoToJson(UserSecurityInfo data) => json.encode(data.toJson());

class UserSecurityInfo {
  UserSecurityInfo({
    required this.userId,
    this.email,
    this.phoneNumber,
    required this.isEmailAuthentication,
    required this.isPhoneAuthentication,
    required this.isTwoFactorAuthentication,
  });

  String userId;
  String? email;
  String? phoneNumber;
  bool isEmailAuthentication;
  bool isPhoneAuthentication;
  bool isTwoFactorAuthentication;

  bool isFinishedRegister() {
    return (email?.isNotEmpty ?? false) && (phoneNumber?.isNotEmpty ?? false);
  }

  factory UserSecurityInfo.fromJson(Map<String, dynamic> json) => UserSecurityInfo(
        userId: json["userId"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        isEmailAuthentication: json["isEmailAuthentication"],
        isPhoneAuthentication: json["isPhoneAuthentication"],
        isTwoFactorAuthentication: json["isTwoFactorAuthentication"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "phoneNumber": phoneNumber,
        "isEmailAuthentication": isEmailAuthentication,
        "isPhoneAuthentication": isPhoneAuthentication,
        "isTwoFactorAuthentication": isTwoFactorAuthentication,
      };
}

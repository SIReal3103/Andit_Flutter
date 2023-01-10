// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.isBot,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.isActive,
    required this.isPhoneConfirmed,
    required this.isEmailConfirmed,
    required this.email,
    required this.roleId,
    required this.userId,
    required this.phoneNumber,
  });

  bool isBot;
  String id;
  int updatedAt;
  int createdAt;
  bool isActive;
  bool isPhoneConfirmed;
  bool isEmailConfirmed;
  String email;
  String roleId;
  String userId;
  String phoneNumber;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        isBot: json["isBot"],
        id: json["_id"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"],
        isActive: json["isActive"],
        isPhoneConfirmed: json["isPhoneConfirmed"],
        isEmailConfirmed: json["isEmailConfirmed"],
        email: json["email"],
        roleId: json["roleId"],
        userId: json["userId"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "isBot": isBot,
        "_id": id,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "isActive": isActive,
        "isPhoneConfirmed": isPhoneConfirmed,
        "isEmailConfirmed": isEmailConfirmed,
        "email": email,
        "roleId": roleId,
        "userId": userId,
        "phoneNumber": phoneNumber,
      };
}

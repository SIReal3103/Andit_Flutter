import 'dart:convert';
import 'package:andit/utils/extensions/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

UserIdentity userIdentityFromJson(String str) =>
    UserIdentity.fromJson(json.decode(str));

String userIdentityToJson(UserIdentity data) => json.encode(data.toJson());

class UserIdentity {
  UserIdentity({
    required this.id,
    required this.userId,
    required this.nationality,
    required this.nationalId,
    required this.fullName,
    required this.dateOfBirth,
    required this.residentialAddress,
    this.postalCode,
    this.city,
    required this.country,
    this.passport,
    this.frontViewOfIdCard,
    this.backViewOfIdCard,
    this.driveLicense,
    required this.selfPortraitView,
    required this.status,
    required this.createdAt,
  });

  String id;
  String userId;
  String nationality;
  String nationalId;
  String fullName;
  String dateOfBirth;
  String residentialAddress;
  String? postalCode;
  String? city;
  String country;
  String? passport;
  String? frontViewOfIdCard;
  String? backViewOfIdCard;
  String? driveLicense;
  String selfPortraitView;
  String status;
  int createdAt;

// export const KYC_STATUS = {
//   SUBMITTED: 'submitted',
//   VERIFIED: 'verified',
//   REJECTED: 'rejected',
// };
  String statusTitle() {
    if (status == 'submitted') {
      return "verify_status.submitted".tr();
    } else if (status == 'confirmed') {
      return "verify_status.confirmed".tr();
    } else {
      return "verify_status.rejected".tr();
    }
  }

  Color statusColor(BuildContext context) {
    if (status == 'submitted') {
      return Colors.orange;
    } else if (status == 'confirmed') {
      return Theme.of(context).colorScheme.positiveColor;
    } else {
      return Theme.of(context).colorScheme.negativeColor;
    }
  }

  factory UserIdentity.fromJson(Map<String, dynamic> json) => UserIdentity(
        id: json["_id"],
        userId: json["userId"],
        nationality: json["nationality"],
        nationalId: json["nationalId"],
        fullName: json["fullName"],
        dateOfBirth: json["dateOfBirth"],
        residentialAddress: json["residentialAddress"],
        postalCode: json["postalCode"],
        city: json["city"],
        country: json["country"],
        passport: json["passport"],
        frontViewOfIdCard: json["frontViewOfIdCard"],
        backViewOfIdCard: json["backViewOfIdCard"],
        driveLicense: json["driveLicense"],
        selfPortraitView: json["selfPortraitView"],
        status: json["status"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "nationality": nationality,
        "nationalId": nationalId,
        "fullName": fullName,
        "dateOfBirth": dateOfBirth,
        "residentialAddress": residentialAddress,
        "postalCode": postalCode,
        "city": city,
        "country": country,
        "passport": passport,
        "frontViewOfIdCard": frontViewOfIdCard,
        "backViewOfIdCard": backViewOfIdCard,
        "driveLicense": driveLicense,
        "selfPortraitView": selfPortraitView,
        "status": status,
        "createdAt": createdAt,
      };
}

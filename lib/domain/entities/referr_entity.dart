// To parse this JSON data, do
//
//     final referrerModel = referrerModelFromJson(jsonString);

import 'dart:convert';

ReferrerModel referrerModelFromJson(String str) => ReferrerModel.fromJson(json.decode(str) as Map<String,dynamic>);

String referrerModelToJson(ReferrerModel data) => json.encode(data.toJson());

class ReferrerModel {
  int? referrerId;
  int? status;
  bool? valid;

  ReferrerModel({
    this.referrerId,
    this.status,
    this.valid,
  });

  factory ReferrerModel.fromJson(Map<String, dynamic> json) => ReferrerModel(
    referrerId: json["ReferrerId"] as int ,
    status: json["status"] as int ,
    valid: json["valid"] as bool,
  );

  Map<String, dynamic> toJson() => {
    "ReferrerId": referrerId,
    "status": status,
    "valid": valid,
  };
}

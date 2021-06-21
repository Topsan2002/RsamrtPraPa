// To parse this JSON data, do
//
//     final memberDataUnit = memberDataUnitFromJson(jsonString);

import 'dart:convert';

List<MemberDataUnit> memberDataUnitFromJson(String str) => List<MemberDataUnit>.from(json.decode(str).map((x) => MemberDataUnit.fromJson(x)));

String memberDataUnitToJson(List<MemberDataUnit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberDataUnit {
    MemberDataUnit({
      required  this.unit,
      required  this.totalPay,
      required  this.status,
    });

    String unit;
    String totalPay;
    String status;

    factory MemberDataUnit.fromJson(Map<String, dynamic> json) => MemberDataUnit(
        unit: json["unit"],
        totalPay: json["total_pay"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "unit": unit,
        "total_pay": totalPay,
        "status": status,
    };
}

// To parse this JSON data, do
//
//     final memberData = memberDataFromJson(jsonString);

import 'dart:convert';

List<MemberData> memberDataFromJson(String str) =>
    List<MemberData>.from(json.decode(str).map((x) => MemberData.fromJson(x)));

String memberDataToJson(List<MemberData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberData {
  MemberData({
    required this.waterId,
    required this.memName,
    required this.memTel,
    required this.memMobile,
    required this.memAddress,
    required this.memBin,
  });

  String waterId;
  String memName;
  String memTel;
  String memMobile;
  String memAddress;
  int memBin;

  factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
        waterId: json["water_id"],
        memName: json["mem_name"],
        memTel: json["mem_tel"],
        memMobile: json["mem_mobile"],
        memAddress: json["mem_address"],
        memBin: json["mem_bin"] == null ? 0 : json["mem_bin"],
      );

  Map<String, dynamic> toJson() => {
        "water_id": waterId,
        "mem_name": memName,
        "mem_tel": memTel,
        "mem_mobile": memMobile,
        "mem_address": memAddress,
        "mem_bin": memBin,
      };
}

// To parse this JSON data, do
//
//     final dasdBoardData = dasdBoardDataFromJson(jsonString);

import 'dart:convert';

List<DasdBoardData> dasdBoardDataFromJson(String str) => List<DasdBoardData>.from(json.decode(str).map((x) => DasdBoardData.fromJson(x)));

String dasdBoardDataToJson(List<DasdBoardData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DasdBoardData {
    DasdBoardData({
      required  this.profileName,
      required  this.member,
      required  this.unitData,
    });

    String profileName;
    String member;
    String unitData;

    factory DasdBoardData.fromJson(Map<String, dynamic> json) => DasdBoardData(
        profileName: json["profile_name"],
        member: json["member"],
        unitData: json["unit_data"],
    );

    Map<String, dynamic> toJson() => {
        "profile_name": profileName,
        "member": member,
        "unit_data": unitData,
    };
}

// To parse this JSON data, do
//
//     final dasdBoardData = dasdBoardDataFromJson(jsonString);

import 'dart:convert';

List<DasdBoardData> dasdBoardDataFromJson(String str) => List<DasdBoardData>.from(json.decode(str).map((x) => DasdBoardData.fromJson(x)));

String dasdBoardDataToJson(List<DasdBoardData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DasdBoardData {
    DasdBoardData({
      required  this.memberAll,
      required  this.member,
    });

    String memberAll;
    String member;

    factory DasdBoardData.fromJson(Map<String, dynamic> json) => DasdBoardData(
        memberAll: json["member_all"],
        member: json["member"],
    );

    Map<String, dynamic> toJson() => {
        "member_all": memberAll,
        "member": member,
    };
}

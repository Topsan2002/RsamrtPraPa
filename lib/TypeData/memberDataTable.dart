// To parse this JSON data, do
//
//     final memberDataTable = memberDataTableFromJson(jsonString);

import 'dart:convert';

List<MemberDataTable> memberDataTableFromJson(String str) => List<MemberDataTable>.from(json.decode(str).map((x) => MemberDataTable.fromJson(x)));

String memberDataTableToJson(List<MemberDataTable> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberDataTable {
    MemberDataTable({
       required this.waterId,
       required this.memName,
    });

    String waterId;
    String memName;

    factory MemberDataTable.fromJson(Map<String, dynamic> json) => MemberDataTable(
        waterId: json["water_id"],
        memName: json["mem_name"],
    );

    Map<String, dynamic> toJson() => {
        "water_id": waterId,
        "mem_name": memName,
    };
}

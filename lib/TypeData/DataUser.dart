// To parse this JSON data, do
//
//     final dataUser = dataUserFromJson(jsonString);

import 'dart:convert';

List<DataUser> dataUserFromJson(String str) => List<DataUser>.from(json.decode(str).map((x) => DataUser.fromJson(x)));

String dataUserToJson(List<DataUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataUser {
    DataUser({
        required this.userId,
        required this.adminId,
    });

    String userId;
    String adminId;

    factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        userId: json["user_id"],
        adminId: json["admin_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "admin_id": adminId,
    };
}

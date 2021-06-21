// To parse this JSON data, do
//
//     final adminData = adminDataFromJson(jsonString);

import 'dart:convert';

List<AdminData> adminDataFromJson(String str) => List<AdminData>.from(json.decode(str).map((x) => AdminData.fromJson(x)));

String adminDataToJson(List<AdminData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminData {
    AdminData({
      required  this.name,
      required  this.address,
      required  this.phone,
      required  this.email,
    });

    String name;
    String address;
    String phone;
    String email;

    factory AdminData.fromJson(Map<String, dynamic> json) => AdminData(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
    };
}

// To parse this JSON data, do
//
//     final payData = payDataFromJson(jsonString);

import 'dart:convert';

List<PayData> payDataFromJson(String str) => List<PayData>.from(json.decode(str).map((x) => PayData.fromJson(x)));

String payDataToJson(List<PayData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PayData {
    PayData({
      required  this.name,
      required  this.pay,
    });

    String name;
    String pay;

    factory PayData.fromJson(Map<String, dynamic> json) => PayData(
        name: json["name"],
        pay: json["pay"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "pay": pay,
    };
}

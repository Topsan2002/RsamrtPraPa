// To parse this JSON data, do
//
//     final payTotalData = payTotalDataFromJson(jsonString);

import 'dart:convert';

List<PayTotalData> payTotalDataFromJson(String str) => List<PayTotalData>.from(json.decode(str).map((x) => PayTotalData.fromJson(x)));

String payTotalDataToJson(List<PayTotalData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PayTotalData {
    PayTotalData({
      required  this.total,
    });

    String total;

    factory PayTotalData.fromJson(Map<String, dynamic> json) => PayTotalData(
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
    };
}

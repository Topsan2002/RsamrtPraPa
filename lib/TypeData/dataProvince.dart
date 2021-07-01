// To parse this JSON data, do
//
//     final dataProvince = dataProvinceFromJson(jsonString);

import 'dart:convert';

List<DataProvince> dataProvinceFromJson(String str) => List<DataProvince>.from(json.decode(str).map((x) => DataProvince.fromJson(x)));

String dataProvinceToJson(List<DataProvince> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataProvince {
    DataProvince({
      required  this.provinceCode,
      required  this.provinceName,
    });

    String provinceCode;
    String provinceName;

    factory DataProvince.fromJson(Map<String, dynamic> json) => DataProvince(
        provinceCode: json["province_code"],
        provinceName: json["province_name"],
    );

    Map<String, dynamic> toJson() => {
        "province_code": provinceCode,
        "province_name": provinceName,
    };
}

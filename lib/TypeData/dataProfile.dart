// To parse this JSON data, do
//
//     final dataProfile = dataProfileFromJson(jsonString);

import 'dart:convert';

List<DataProfile> dataProfileFromJson(String str) => List<DataProfile>.from(json.decode(str).map((x) => DataProfile.fromJson(x)));

String dataProfileToJson(List<DataProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataProfile {
    DataProfile({
      required  this.profileName,
      required  this.profileSub,
      required  this.address,
      required  this.tombon,
      required  this.umpher,
      required  this.province,
      required  this.zipcode,
      required  this.phone,
      required  this.fax,
      required  this.email,
      required  this.vat,
      required  this.manager,
      required  this.service,
      required  this.provinceCode,
    });

    String profileName;
    String profileSub;
    String address;
    String tombon;
    String umpher;
    String province;
    String zipcode;
    String phone;
    String fax;
    String email;
    String vat;
    String manager;
    String service;
    String provinceCode;

    factory DataProfile.fromJson(Map<String, dynamic> json) => DataProfile(
        profileName: json["profile_name"],
        profileSub: json["profile_sub"],
        address: json["address"],
        tombon: json["tombon"],
        umpher: json["umpher"],
        province: json["province"],
        zipcode: json["zipcode"],
        phone: json["phone"],
        fax: json["fax"],
        email: json["email"],
        vat: json["vat"],
        manager: json["manager"],
        service: json["service"],
        provinceCode: json["province_code"],
    );

    Map<String, dynamic> toJson() => {
        "profile_name": profileName,
        "profile_sub": profileSub,
        "address": address,
        "tombon": tombon,
        "umpher": umpher,
        "province": province,
        "zipcode": zipcode,
        "phone": phone,
        "fax": fax,
        "email": email,
        "vat": vat,
        "manager": manager,
        "service": service,
        "province_code": provinceCode,
    };
}

// To parse this JSON data, do
//
//     final userdata = userdataFromJson(jsonString);

import 'dart:convert';

List<Userdata> userdataFromJson(String str) => List<Userdata>.from(json.decode(str).map((x) => Userdata.fromJson(x)));

String userdataToJson(List<Userdata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Userdata {
    Userdata({
       required this.userId,
       required this.img,
       required this.name,
       required this.email,
       required this.password,
       required this.departId,
       required this.cardId,
       required this.userNo,
       required this.billId,
       required this.userCash,
       required this.status,
       required this.lastLogin,
    });

    String userId;
    String img;
    String name;
    String email;
    String password;
    String departId;
    String cardId;
    String userNo;
    String billId;
    int userCash;
    String status;
    DateTime lastLogin;

    factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        userId: json["user_id"],
        img: json["img"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        departId: json["depart_id"],
        cardId: json["card_id"],
        userNo: json["user_no"],
        billId: json["bill_id"],
        userCash: json["user_cash"],
        status: json["status"],
        lastLogin: DateTime.parse(json["last_login"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "img": img,
        "name": name,
        "email": email,
        "password": password,
        "depart_id": departId,
        "card_id": cardId,
        "user_no": userNo,
        "bill_id": billId,
        "user_cash": userCash,
        "status": status,
        "last_login": lastLogin.toIso8601String(),
    };
}

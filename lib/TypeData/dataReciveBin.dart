// To parse this JSON data, do
//
//     final dataReciveBin = dataReciveBinFromJson(jsonString);

import 'dart:convert';

List<DataReciveBin> dataReciveBinFromJson(String str) =>
    List<DataReciveBin>.from(
        json.decode(str).map((x) => DataReciveBin.fromJson(x)));

String dataReciveBinToJson(List<DataReciveBin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataReciveBin {
  DataReciveBin({
    required this.profileName,
    required this.profileTax,
    required this.profileAddress,
    required this.profilePhone,
    required this.unidIdReal,
    required this.unitId,
    required this.dateNow,
    required this.waterId,
    required this.userName,
    required this.userAddress,
    required this.idCard,
    required this.userTax,
    required this.lastDate,
    required this.lastUnit,
    required this.nowDate,
    required this.nowUnit,
    required this.unitUse,
    required this.unitPay,
    required this.unitService,
    required this.unitOtherName,
    required this.unitOtherPay,
    required this.unitTotalPay,
    required this.adminName,
    required this.monNow,
    required this.monLast,
    required this.meterLast,
    required this.lastInput,
    required this.lastTotal,
    required this.binPrice,
    required this.totalForUnit,
    required this.pormpay,
  });

  String profileName;
  String profileTax;
  String profileAddress;
  String profilePhone;
  String unidIdReal;
  String unitId;
  String dateNow;
  String waterId;
  String userName;
  String userAddress;
  String idCard;
  String userTax;
  String lastDate;
  String lastUnit;
  String nowDate;
  String nowUnit;
  String unitUse;
  String unitPay;
  String unitService;
  String unitOtherName;
  String unitOtherPay;
  String unitTotalPay;
  String adminName;
  String monNow;
  String monLast;
  String meterLast;
  String lastInput;
  String lastTotal;
  String binPrice;
  String totalForUnit;
  String pormpay;

  factory DataReciveBin.fromJson(Map<String, dynamic> json) => DataReciveBin(
        profileName: json["profile_name"],
        profileTax: json["profile_tax"],
        profileAddress: json["profile_address"],
        profilePhone: json["profile_phone"],
        unidIdReal: json["unid_id_real"],
        unitId: json["unit_id"],
        dateNow: json["date_now"],
        waterId: json["water_id"],
        userName: json["user_name"],
        userAddress: json["user_address"],
        idCard: json["id_card"],
        userTax: json["user_tax"],
        lastDate: json["last_date"],
        lastUnit: json["last_unit"],
        nowDate: json["now_date"],
        nowUnit: json["now_unit"],
        unitUse: json["unit_use"],
        unitPay: json["unit_pay"],
        unitService: json["unit_service"],
        unitOtherName: json["unit_other_name"],
        unitOtherPay: json["unit_other_pay"],
        unitTotalPay: json["unit_total_pay"],
        adminName: json["admin_name"],
        monNow: json["mon_now"],
        monLast: json["mon_last"],
        meterLast: json["meter_last"],
        lastInput: json["last_input"],
        lastTotal: json["last_total"],
        binPrice: json["bin_price"],
        totalForUnit: json["total_for_unit"],
        pormpay: json["pormpay"] == null || json["pormpay"] == ""
            ? 'lock.png'
            : json["pormpay"],
      );

  Map<String, dynamic> toJson() => {
        "profile_name": profileName,
        "profile_tax": profileTax,
        "profile_address": profileAddress,
        "profile_phone": profilePhone,
        "unid_id_real": unidIdReal,
        "unit_id": unitId,
        "date_now": dateNow,
        "water_id": waterId,
        "user_name": userName,
        "user_address": userAddress,
        "id_card": idCard,
        "user_tax": userTax,
        "last_date": lastDate,
        "last_unit": lastUnit,
        "now_date": nowDate,
        "now_unit": nowUnit,
        "unit_use": unitUse,
        "unit_pay": unitPay,
        "unit_service": unitService,
        "unit_other_name": unitOtherName,
        "unit_other_pay": unitOtherPay,
        "unit_total_pay": unitTotalPay,
        "admin_name": adminName,
        "mon_now": monNow,
        "mon_last": monLast,
        "meter_last": meterLast,
        "last_input": lastInput,
        "last_total": lastTotal,
        "bin_price": binPrice,
        "total_for_unit": totalForUnit,
        "pormpay": pormpay,
      };
}

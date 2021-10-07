import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rsmart/screen/confic/components/conficform.dart';
import 'package:rsmart/widget/dialog/alrtdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class DialogUnitOtherPay {
  Future inputOther(BuildContext context) async {
    SharedPreferences keep = await SharedPreferences.getInstance();
    var waterId = keep.getString('water_id');
    var adminID = keep.getString('admin_id');
    var path = keep.getString('path');
    final keyform = GlobalKey<FormBuilderState>();

    void savePayOtherHost() async {
      await path != null;
      var url = Uri.parse(
          "http://${path}/appapi/rsmart/api/appApi/User/api_unit_other.php");
      //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_unit_other.php");
      // var data = {
      //   "unit_other": otherPayName.text,
      //   "amount_other": otherPayTotal.text,
      //   "water_id": waterId
      // };
      //print(data);

      keyform.currentState?.save();
      keyform.currentState?.setInternalFieldValue('water_id', waterId);
      keyform.currentState?.setInternalFieldValue('admin_id', adminID);
      var data = keyform.currentState?.value;

      var response = await http.post(
        url,
        body: data,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => dialogAlert(
            text: 'บันทึกข้อมูลสำเร็จ',
            img: 'assets/icon/ok.png',
          ),
        );
        Timer(Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => dialogAlert(
            text: 'เกิดข้อผิดพลาด',
            img: 'assets/icon/close.png',
          ),
        );
        Timer(Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      }
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('ค่าบริการอื่นๆ')),
          titleTextStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontFamily: 'kanit',
          ),
          content: Container(
            // decoration: BoxDecoration(color: Colors.amber),
            height: 190.h,
            width: 250.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilder(
                  key: keyform,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ชื่อรายการ : ',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      textformVaridate(
                        name: 'unit_other',
                        text: 'ชื่อรายการ',
                        obscureText: false,
                      ),
                      Text(
                        'จำนวนเงิน : ',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      unitformVaridate(
                        name: 'amount_other',
                        text: 'กรุณากรอกจำนวนเงิน',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 5.h,
              ),
              color: HexColor("#1DAE46"),
              textColor: Colors.white,
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              onPressed: () {
                if (keyform.currentState!.validate()) {
                  Navigator.pop(context);
                  savePayOtherHost();
                }
              },
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 5.h,
              ),
              color: Colors.red,
              textColor: Colors.white,
              child: Text(
                'ยกเลิก',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

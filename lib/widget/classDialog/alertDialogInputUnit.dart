import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsmart/screen/confic/components/conficform.dart';
import 'package:http/http.dart' as http;
import 'package:rsmart/widget/dialog/alrtdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogUnitInput {
  Future unitMinLast(BuildContext context, dynamic data) async {
    SharedPreferences keep = await SharedPreferences.getInstance();
    var path = keep.getString('path');
    await path != null;
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_input_unit_min_last.php");

    print(data);
    print('result');

    var response = await http.post(url, body: data, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    });
    print(response.body);
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
        Navigator.pop(context);
      });
    } else if (response.statusCode == 401) {
      showDialog(
        context: context,
        builder: (context) => dialogAlert(
          text: 'กรุณาใส่เลขมิตเตอร์',
          img: 'assets/icon/close.png',
        ),
      );
      Timer(Duration(milliseconds: 1500), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => dialogAlert(
          text: 'คุณได้บันทึกข้อมูลเดือนนี้ไปแล้ว',
          img: 'assets/icon/close.png',
        ),
      );
      Timer(Duration(milliseconds: 1500), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

  Future inputUnit(BuildContext context) async {
    SharedPreferences keep = await SharedPreferences.getInstance();
    var waterId = keep.getString('water_id');
    var adminID = keep.getString('admin_id');
    var path = keep.getString('path');
    final keyform = GlobalKey<FormBuilderState>();
    void saveUnitHost() async {
      await path != null;
      var url = Uri.parse(
          "http://${path}/appapi/rsmart/api/appApi/User/api_input_unit.php");

      keyform.currentState?.save();
      keyform.currentState?.setInternalFieldValue('water_id', waterId);
      keyform.currentState?.setInternalFieldValue('admin_id', adminID);
      var data = keyform.currentState?.value;

      var response = await http.post(url, body: data, headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      });

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
      } else if (response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (context) => dialogAlert(
            text: 'กรุณาใส่เลขมิตเตอร์',
            img: 'assets/icon/close.png',
          ),
        );
        Timer(Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      } else if (response.statusCode == 402) {
        showDialog(
          context: context,
          builder: (context) => alertdialogConfirmDetial(
            title: 'แจ้งเตือน',
            detial:
                'เลขที่กรอกน้อยกว่าเดือนที่ผ่านมา คุณแน่ใจหรือไม่ว่าเป็นการเริ่มมิเตอร์ใหม่ กรุณากดตกลง',
            press: () {
              unitMinLast(context, data);
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => dialogAlert(
            text: 'คุณได้บันทึกข้อมูลเดือนนี้ไปแล้ว',
            img: 'assets/icon/close.png',
          ),
        );
        Timer(Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      }

      print(response.body);
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('${name}'),
            titleTextStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
            content: Container(
              height: 122.h,
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'บันทึกการใช้น้ำ',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Text(
                    'ตัวเลขมาตรน้ำเดือนปัจจุบัน : ',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  FormBuilder(
                    key: keyform,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: unitformVaridate(
                      name: 'unit_input',
                      text: 'กรุณากรอกเลขมาตรน้ำ',
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
                    saveUnitHost();
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
                child: Text('ยกเลิก',
                    style: TextStyle(
                      fontSize: 12.sp,
                    )),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

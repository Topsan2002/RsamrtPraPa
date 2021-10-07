import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rsmart/TypeData/memberDataUnit.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:rsmart/widget/dowloadWidget/dowloandWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class memberdataTitle extends StatelessWidget {
  final future;
  final String name;
  const memberdataTitle({
    Key? key,
    required this.future,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 10.h,
      ),
      child: FutureBuilder(
          future: future,
          builder: (BuildContext buildcontext, AsyncSnapshot snapshot) {
            if (snapshot.data == 0) {
              return Center(
                  child: Text(
                'เกิดข้อผิดพลาด',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ));
            } else if (snapshot.hasData) {
              var res = jsonDecode(snapshot.data);
              List<MemberDataUnit> memData =
                  memberDataUnitFromJson(jsonEncode(res['data']));
              return Column(
                children: memData
                    .map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: textHeader(
                              text: 'ข้อมูลผู้ใช้น้ำ',
                            ),
                          ),
                          textDataUser(
                            text: 'ชื่อ-นามสกุล : ${name}',
                          ),
                          textDataUser(
                            text: 'เลขอ่านครั้งก่อน :  ${e.unit}',
                          ),
                          textDataUser(
                            text: 'ต้องจ่ายเดือนนี้ : ${e.totalPay} บาท',
                          ),
                          textDataUser(
                            text: 'สถานะ : ${e.status}',
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );
            } else {
              return Center(
                child: dowlondWidget(),
              );
            }
          }),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rsmart/TypeData/dashBoardData.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rsmart/screen/menu/components/menutextStyle.dart';
import 'package:rsmart/widget/dowloadWidget/dowloandWidget.dart';

class titleMenu extends StatelessWidget {
  final future;
  const titleMenu({
    Key? key,
    required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: future,
            builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
              if (snapshot.data == 1) {
                return Text('API ERROR');
              } else if (snapshot.hasData) {
                var res = jsonDecode(snapshot.data);
                List<DasdBoardData> dashboard =
                    dasdBoardDataFromJson(jsonEncode(res['data']));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dashboard
                      .map(
                        (e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/icon/water.png',
                                height: 80.h,
                              ),
                            ),
                            simpleText(
                              text: e.profileName,
                            ),
                            simpleText(
                              text: 'จำนวนผู้ใช้น้ำทั้งหมด  : ${e.member} บ้าน',
                            ),
                            simpleText(
                                text: 'จดค่าน้ำแล้ว : ${e.unitData} บ้าน'),
                            SizedBox(height: 10.h)
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
            },
          ),
        ],
      ),
    );
  }
}

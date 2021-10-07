import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/payData.dart';
import 'package:rsmart/screen/dashboard/widget/tablemember.dart';
import 'package:rsmart/screen/manage_unit/manage_unit.dart';
import 'package:rsmart/widget/dowloadWidget/dowloandWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class payList extends StatelessWidget {
  final future;
  const payList({
    Key? key,
    required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext buildcontext, AsyncSnapshot snapshot) {
        if (snapshot.data == 0) {
          return Center(
            child: Text(
              'ไม่ข้อมูล',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          var res = jsonDecode(snapshot.data);
          var total = res['total'];
          List<PayData> data = payDataFromJson(jsonEncode(res['data']));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: data
                    .map(
                      (e) => Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.h,
                              bottom: 10.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: textTitleList(
                                    text: e.name,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: textTitleList(
                                      text: e.address,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: textTitleList(
                                      text: e.pay,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1.h,
                            width: double.infinity,
                            //margin: EdgeInsets.only(top: .h),
                            decoration: BoxDecoration(
                              color: HexColor("#C4C4C4"),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: textTitleList(
                        text: 'รวมทั้งสิ้น',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: textTitleList(
                        text: total,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 1.h,
                width: double.infinity,
                //margin: EdgeInsets.only(top: .h),
                decoration: BoxDecoration(
                  color: HexColor("#C4C4C4"),
                ),
              ),
            ],
          );
        } else {
          return Container(
            margin: EdgeInsets.only(top: 30.h),
            child: dowlondWidgetTable(),
          );
        }
      },
    );
  }
}

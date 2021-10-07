import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/memberData.dart';
import 'package:rsmart/screen/manage_unit/manage_unit.dart';
import 'package:rsmart/widget/dowloadWidget/dowloandWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class memberList extends StatelessWidget {
  final stream;
  const memberList({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext buildcontext, AsyncSnapshot snapshot) {
        if (snapshot.data == 0) {
          return Center(
            child: Text(
              'ไม่พบผู้ใช้น้ำ',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          List<MemberData> data = memberDataFromJson(jsonEncode(snapshot.data));
          return Column(
            children: data
                .map(
                  (e) => Column(
                    children: [
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          SharedPreferences member =
                              await SharedPreferences.getInstance();
                          member.setString('water_id', e.waterId);
                          member.setString('member_name', e.memName);
                          member.setInt('member_bin', e.memBin);
                          //print(waterID);
                          Navigator.push(
                            context,
                            PageTransition(
                              child: ManageUnit(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: textTitleList(
                                  text: e.memName,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: textTitleList(
                                    text: e.waterId,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: textTitleList(
                                    text: e.memAddress,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

class textTitleList extends StatelessWidget {
  final String text;
  const textTitleList({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
      ),
    );
  }
}

class lineblue extends StatelessWidget {
  const lineblue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }
}

class searchBox extends StatelessWidget {
  final onChanged;
  const searchBox({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.sp,
          color: HexColor("#E5E5E5"),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 7.h),
          suffixIconConstraints: BoxConstraints(
            minHeight: 20.h,
            minWidth: 20.h,
          ),
          suffixIcon: Container(
            margin: EdgeInsets.only(right: 10.h),
            child: Icon(
              Icons.search_outlined,
              size: 24.sp,
            ),
          ),
          border: InputBorder.none,
          hintText: 'ค้นหาด้วย เลขผู้ใช้น้ำ บ้านเลขที่ เบอร์โทรศัพท์',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: HexColor("#C4C4C4"),
          ),
        ),
      ),
    );
  }
}

class textnormalTitle extends StatelessWidget {
  final String text;
  const textnormalTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }
}

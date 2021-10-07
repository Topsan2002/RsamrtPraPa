import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/memberData.dart';
import 'package:rsmart/TypeData/memberDataTable.dart';
import 'package:rsmart/api/api.dart';

import 'package:rsmart/screen/dashboard/componentes/dashboardStyle.dart';
import 'package:rsmart/screen/dashboard/widget/tablemember.dart';
import 'package:rsmart/screen/dashboard/widget/widgetDashboard.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/manage_unit/manage_unit.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var path;

  List<Map<String, dynamic>> memberData = [];

  final StreamController memberStream = new StreamController();

  void initState() {
    super.initState();
    getPath();
    getmemberData();
  }

  getPath() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      path = user.getString('path');
    });
  }

  void getmemberData() async {
    await path != null;

    var url = Uri.parse(
        'http://${path}/appapi/rsmart/api/appApi/User/api_get_data_member.php');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      },
    );
    var res = jsonDecode(response.body);

    setState(() {
      List<Map<String, dynamic>> nowData =
          new List<Map<String, dynamic>>.from(res['data']);
      memberData = nowData;
      memberStream.sink.add(nowData);
    });
    //print(response.body);
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = memberData;
    } else {
      results = memberData
          .where((user) => user
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toString().toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      if (results.length <= 0) {
        print('object');
        memberStream.sink.add(0);
      } else {
        print('has data');
        memberStream.sink.add(results);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'บันทึกค่าน้ำเดือนปัจจุบัน',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: ListView(
        children: [
          bgWhiteSet(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: textnormalTitle(
                    text: 'รายชื่อผู้ใช้น้ำ',
                  ),
                ),
                textnormalTitle(
                  text: 'ค้นหาผู้ใช้น้ำ : ',
                ),
                searchBox(
                  onChanged: (value) => _runFilter(value),
                ),
                SizedBox(
                  height: 10.h,
                ),
                lineblue(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: textTitleList(
                          text: 'ชื่อ-นามสกุล',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: textTitleList(
                          text: 'เลขผู้ใช้น้ำ',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: textTitleList(
                          text: 'บ้านเลขที่',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                lineblue(),
                memberList(
                  stream: memberStream.stream,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class bgWhiteSet extends StatelessWidget {
  final child;
  const bgWhiteSet({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 10.h,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: child,
      ),
    );
  }
}

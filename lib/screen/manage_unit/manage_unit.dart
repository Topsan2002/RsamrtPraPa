import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/manage_unit/componentes/memberdataTitle.dart';
import 'package:rsmart/screen/menu/components/menutool.dart';
import 'package:rsmart/test/print.dart';
import 'package:rsmart/test/printbill.dart';
import 'package:rsmart/widget/classDialog/alertDialogInputUnit.dart';
import 'package:rsmart/widget/classDialog/alertDialogOtherPay.dart';
import 'package:rsmart/widget/dowloadWidget/dowloandWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageUnit extends StatefulWidget {
  @override
  _ManageUnitState createState() => _ManageUnitState();
}

class _ManageUnitState extends State<ManageUnit> {
  var waterId;
  var memName;
  var adminID;
  var path;
  var bin_status;

  DialogUnitInput dialogUnitInput = new DialogUnitInput();
  DialogUnitOtherPay dialogUnitOtherPay = new DialogUnitOtherPay();

  @override
  void initState() {
    super.initState();
    _getWaterID();
  }

  _getWaterID() async {
    SharedPreferences keep = await SharedPreferences.getInstance();

    setState(() {
      waterId = keep.getString('water_id');
      memName = keep.getString('member_name');
      adminID = keep.getString('admin_id');
      path = keep.getString('path');
      bin_status = keep.getInt('member_bin');
      print('result ${bin_status}');
    });
  }

  Future getMemberData() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_member_data.php");

    // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_member_data.php");

    var data = {"water_id": waterId};
    var response = await http.post(
      url,
      body: data,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'จัดการผู้ใช้น้ำ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: bin_status == null
          ? Center(
              child: dowlondWidget(),
            )
          : RefreshIndicator(
              onRefresh: () {
                return Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: ManageUnit()),
                );
              },
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 0),
                    child: memberdataTitle(
                      name: '${memName}',
                      future: getMemberData(),
                    ),
                  ),
                  bgWhiteSet(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        menuitem(
                          text: 'บันทึกการใช้น้ำ',
                          img: 'assets/icon/write.png',
                          press: () {
                            dialogUnitInput.inputUnit(context);
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        menuitem(
                          text: 'ค่าบริการอื่นๆ',
                          img: 'assets/icon/tools.png',
                          press: () {
                            dialogUnitOtherPay.inputOther(context);
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        menuitem(
                          text: 'แจ้งหนี้',
                          img: 'assets/icon/payment.png',
                          press: () {
                            bin_status == 0
                                ? Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: PrintTest(),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: PrintReciveBin(),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

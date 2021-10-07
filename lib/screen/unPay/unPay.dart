import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/payData.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/dashboard/widget/tablemember.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:http/http.dart' as http;
import 'package:rsmart/screen/pay/components/payTable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnPay extends StatefulWidget {
  const UnPay({Key? key}) : super(key: key);

  @override
  _UnPayState createState() => _UnPayState();
}

class _UnPayState extends State<UnPay> {
  var path;

  void initState() {
    super.initState();
    getPath();
  }

  getPath() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      path = user.getString('path');
    });
  }

  Future getUnPayData() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_get_data_unpay.php");
    //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_get_data_unpay.php");

    var data = {};

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
    });

    //print(response.body);

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
          'รายการค้างชำระ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushReplacement(context,
              PageTransition(child: UnPay(), type: PageTransitionType.fade));
        },
        child: ListView(
          children: [
            bgWhiteSet(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: textnormalTitle(
                      text: 'รายการค้างชำระ',
                    ),
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
                        flex: 2,
                        child: Center(
                          child: textTitleList(
                            text: 'บ้านเลขที่',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: textTitleList(
                            text: 'จำนวนเงิน',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  lineblue(),
                  payList(
                    future: getUnPayData(),
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

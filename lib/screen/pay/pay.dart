import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/payData.dart';
import 'package:rsmart/TypeData/payTotalData.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/dashboard/widget/tablemember.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:http/http.dart' as http;
import 'package:rsmart/screen/pay/components/payTable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pay extends StatefulWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  var path;

  //@override
  void initState() {
    super.initState();
    getPath();
  }

  // final StreamController _steam = new StreamController();

  getPath() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      path = user.getString('path');
    });
  }

  Future getPay() async {
    print('${path} this');
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_get_data_pay.php");
    // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_get_data_pay.php");
    var response = await http.get(url, headers: <String, String>{
      "Content-type": "application/x-www-form-urlencoded; charset=utf-8"
    });

    // print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      //_steam.sink.add(response.body);
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
          'รายการชำระเงินแล้ว',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushReplacement(
            context,
            PageTransition(child: Pay(), type: PageTransitionType.fade),
          );
        },
        child: ListView(
          children: [
            bgWhiteSet(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: textnormalTitle(
                      text: 'รายการชำระเงินแล้ว',
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
                    future: getPay(),
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

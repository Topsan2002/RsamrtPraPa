import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/screen/confic/confic.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/editprofile/edit_profile.dart';
import 'package:rsmart/screen/menu/components/menutile.dart';
import 'package:rsmart/screen/menu/components/menutool.dart';
import 'package:rsmart/screen/pay/pay.dart';
import 'package:rsmart/screen/unPay/unPay.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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

  Future getDataDashBoard() async {
    await path != null;
    //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_profile_show.php");
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_profile_show.php");

    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Navigator.pushReplacement(
              context,
              PageTransition(
                child: Menu(),
                type: PageTransitionType.fade,
              ),
            );
          },
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    titleMenu(
                      future: getDataDashBoard(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.h,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      child: Column(
                        children: [
                          menuitem(
                            text: 'บันทึกค่าน้ำปัจจุบัน',
                            img: 'assets/icon/write.png',
                            press: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: Dashboard(),
                                  type: PageTransitionType.rightToLeft,
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          menuitem(
                            text: 'จัดการข้อมูลองค์กร',
                            img: 'assets/icon/dossier.png',
                            press: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: EditProfile(),
                                ),
                              );
                            },
                          ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // menuitem(
                          //   text: 'บันทึกค่าน้ำย้อนหลัง',
                          //   img: 'assets/icon/return.png',
                          //   press: () {
                          //     Navigator.push(
                          //       context,
                          //       PageTransition(
                          //           type: PageTransitionType.rightToLeft,
                          //           child: LastUnit()),
                          //     );
                          //   },
                          // ),
                          SizedBox(
                            height: 10.h,
                          ),
                          menuitem(
                            text: 'รายการชำระเงินแล้ว',
                            img: 'assets/icon/doc_blue.png',
                            press: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Pay()));
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          menuitem(
                            text: 'รายการค้างชำระ',
                            img: 'assets/icon/doc.png',
                            press: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: UnPay()),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () async {
                              SharedPreferences user =
                                  await SharedPreferences.getInstance();
                              user.remove('user_id');
                              user.remove('admin_id');
                              user.remove('water_id');
                              user.remove('member_name');
                              user.remove('path');
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Confic(),
                                    type: PageTransitionType.fade),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.h,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[300],
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/icon/logout.png',
                                  height: 40.h,
                                ),
                                title: Text(
                                  'ออกจากระบบ',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

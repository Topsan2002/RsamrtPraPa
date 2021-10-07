import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/screen/confic/components/conficform.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:rsmart/screen/login/login.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:http/http.dart' as http;
import 'package:rsmart/widget/dialog/alrtdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Confic extends StatefulWidget {
  const Confic({Key? key}) : super(key: key);

  @override
  _ConficState createState() => _ConficState();
}

class _ConficState extends State<Confic> {
  var api_path = TextEditingController();
  final form = GlobalKey<FormBuilderState>();
  void check() async {
    var url = Uri.parse(
        "http://demo.rsmartthailand.com/appapi/rsmart/api/appApi/checkConfic/api_test_confic.php");
    // var url =
    //     Uri.parse("http://192/rsmart/api/appApi/test/api_test_confic.php");

    // var data = {"path": api_path.text};
    form.currentState?.save();
    var data = form.currentState?.value;

    var response = await http.post(url, body: data, headers: {
      'Content-Type': 'application/x-www-form-urlencoded;  charset=utf-8'
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
      print("OK");

      SharedPreferences user = await SharedPreferences.getInstance();
      user.setString('path', form.currentState?.value['path']);

      showDialog(
        context: context,
        builder: (context) => dialogAlert(
          text: 'เชื่อมต่อฐานข้อมูลสำเร็จ',
          img: 'assets/icon/ok.png',
        ),
      );

      Timer(Duration(milliseconds: 1000), () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          PageTransition(type: PageTransitionType.fade, child: Login()),
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => dialogAlert(
          text: 'เชื่อต่อฐานข้อมูลไม่สำเร็จ',
          img: 'assets/icon/close.png',
        ),
      );
      Timer(
        Duration(
          milliseconds: 1000,
        ),
        () {
          Navigator.pop(context);
        },
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('ไม่พบข้อมูลURLของคุณ')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            bgWhiteSet(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    TextHerder(text: "ประปาเพื่อชมชน"),
                    Container(
                      margin: EdgeInsets.all(20.h),
                      child: Image.asset(
                        'assets/icon/confic.png',
                        height: 160.h,
                      ),
                    ),
                    FormBuilder(
                      key: form,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: textformVaridate(
                          name: 'path',
                          text: 'url ของคุณ',
                          icon: Icons.cast_connected,
                          obscureText: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text('ตัวอย่างการใส่url demo.rsmartthailand.com ',
                        style: TextStyle(
                          fontSize: 12.sp,
                        )),
                    RoundBg(
                      color: Colors.blue[300],
                      child: FlatButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            check();
                          }
                        },
                        child: Text(
                          'เชื่อมต่อฐานข้อมูล',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

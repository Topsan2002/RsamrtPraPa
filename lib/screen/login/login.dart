import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/DataUser.dart';
import 'package:rsmart/screen/confic/components/conficform.dart';

import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:http/http.dart' as http;
import 'package:rsmart/screen/menu/menu.dart';
import 'package:rsmart/widget/dialog/alrtdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var username = TextEditingController();
  var password = TextEditingController();
  var uID;
  var adId;
  var path;
  final formkey = GlobalKey<FormBuilderState>();

  void initState() {
    super.initState();
    getPath();
  }

  getPath() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      path = user.getString('path');
      print(path);
    });
  }

  void test() {
    print(username.text);
    print(password.text);
    Navigator.push(
      context,
      PageTransition(child: Dashboard(), type: PageTransitionType.rightToLeft),
    );
  }

  void login() async {
    // var url = Uri.parse("http://192.168.43.26/foodcourt/API/api_login.php");
    //var url = Uri.parse("https://projectajsatit.000webhostapp.com/rsmart/api/appApi/User/api_login.php");

    var url =
        Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_login.php");
    //var url =
    //    Uri.parse("http://192.168.1.26/rsmart/api/appApi/User/api_login.php");
    // var data = {
    //   "user": username.text,
    //   "username": username.text,
    //   "password": password.text
    // };

    formkey.currentState?.save();
    var data = formkey.currentState?.value;

    // print(data);
    var response = await http.post(
      url,
      body: data,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      },
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);

      tranFomrData(res);
      showDialog(
        context: context,
        builder: (context) => dialogAlert(
          text: 'เข้าสู่ระบบสำเร็จ',
          img: 'assets/icon/ok.png',
        ),
      );
      Timer(
        Duration(
          milliseconds: 1000,
        ),
        () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            PageTransition(child: Menu(), type: PageTransitionType.rightToLeft),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => dialogAlert(
          text: 'ชื่อผู้ใช้หรือรหัสผ่านผิดพลาด',
          img: 'assets/icon/close.png',
        ),
      );
      Timer(Duration(milliseconds: 1000), () {
        Navigator.pop(context);
      });
    }
  }

  void tranFomrData(Map data) async {
    // print(data);
    // print('this my data');
    var userdata = dataUserFromJson(jsonEncode(data['data']));

    var t = userdata.map((e) {
      uID = e.userId;
      adId = e.adminId;
    });
    print(t);
    SharedPreferences user = await SharedPreferences.getInstance();
    user.setString('user_id', uID);
    user.setString('admin_id', adId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            bgWhiteSet(
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Image.asset('name'),
                    TextHerder(
                      text: 'ประปาเพื่อชุมชน',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 40),
                      child: Image.asset(
                        'assets/icon/profile.png',
                        width: size.width * 0.3,
                      ),
                    ),
                    FormBuilder(
                      key: formkey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.h,
                            ),
                            child: textformVaridate(
                              name: 'username',
                              text: 'ชื่อผู้ใช้',
                              icon: Icons.account_circle,
                              obscureText: false,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.h,
                            ),
                            child: textformVaridate(
                              name: 'password',
                              text: 'รหัสผ่าน',
                              icon: Icons.lock_outline_rounded,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    RoundBg(
                      color: Colors.blue[300],
                      child: FlatButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            login();
                          }
                        },
                        child: Text(
                          'ลงชื่อเข้าใช้',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

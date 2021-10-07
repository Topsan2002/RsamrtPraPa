import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rsmart/screen/confic/confic.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/login/login.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user_id;
var path;

Future<void> main2() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences user = await SharedPreferences.getInstance();
  user_id = user.getString('user_id');
  path = user.getString('path');
  print(user_id);
  runApp(ScreenUtilInit(
    designSize: Size(375, 812),
    builder: () => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'R-Smart ประปาเพื่อชุมชน',
      theme: ThemeData(
        fontFamily: 'kanit',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'kanit',
            fontSize: 16.sp,
          ),
          centerTitle: true,
        ),
        backgroundColor: HexColor("#EDEDED"),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: HexColor("#EDEDED"),
      ),
      home: path == null
          ? Confic()
          : user_id == null
              ? Login()
              : Menu(),
    ),
  ));
}

void main() {
  main2();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'R-Smart ประปาเพื่อชุมชน',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      //home: user_id == null ? welcome() : TestDashboard(),
    );
  }
}

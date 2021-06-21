import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/DataUser.dart';

import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:http/http.dart' as http;
import 'package:rsmart/screen/menu/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void initState(){
    super.initState();
    getPath();
  }

  getPath() async{
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

   var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_login.php");
  //  var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_login.php");
    var data = {"user":username.text,"username":username.text, "password":password.text};


    var response = await http.post(
      url,
      body:data,
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      },
    );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
    


      var res = jsonDecode(response.body);
        //print(res);
        tranFomrData(res);
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('เข้าสู่ระบบสำเร็จ'))
      );
      Navigator.pushReplacement(
       context,
       PageTransition(child: Menu(), type: PageTransitionType.rightToLeft),
       );
    }else if(response.statusCode == 404){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'))
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่พบข้อมูลผู้ใช้'))
      );
    }
  

  }


  void tranFomrData(Map data) async {
    print(data);
    print('this my data');
     var  userdata = dataUserFromJson(jsonEncode(data['data']));

   var t = userdata.map((e) {
        uID = e.userId;
        adId = e.adminId;
        //print(uID);
        //print('This U ID on top :');
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
      body: ListView(
        children: <Widget> [
          Center(
            child: Column(
              children: <Widget> [
               // Image.asset('name'),
               TextHerder(
                 text: 'ประปาเพื่อชุมชน',
               ),
                Container(
                  margin: EdgeInsets.only(top:50, bottom: 40),
                  child: Image.asset(
                    'assets/icon/profile.png',
                    width: size.width*0.3,
                    ),
                ),
                inputTextLogin(
                  text: 'ชื่อผู้ใช้',
                  controller: username,
                  obscureText:false,
                  icon:Icons.account_circle,
                  ),
                inputTextLogin(
                  text: 'รหัสผ่าน',
                  controller:password,
                  obscureText:true,
                  icon:Icons.lock_outline_rounded
                  ),
                 RoundBg(
                   color: Colors.blue[300],
                   child: FlatButton(
                     onPressed: () {
                      // test();
                      login();
                     },
                     child:Text(
                       'ลงชื่อเข้าใช้',
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight:FontWeight.bold,
                         color: Colors.white,
                       ),
                       ),
                   ),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/adminData.dart';
import 'package:rsmart/screen/confic/confic.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:rsmart/screen/login/login.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShowUserData extends StatefulWidget {
  const ShowUserData({ Key? key }) : super(key: key);

  @override
  _ShowUserDataState createState() => _ShowUserDataState();
}

class _ShowUserDataState extends State<ShowUserData> {


  var adminId;
  var name;
  var email;
  var phone;
  var address;
  var path;

  void initState() {
    super.initState();
    _getUserId();
  }
  
  _getUserId() async {

    SharedPreferences user = await SharedPreferences.getInstance();

    setState(() {
      path = user.getString('path');
      adminId = user.getString('admin_id');
     // print(adminId);
     // print('thhis'); 
     getuserData();
    });

  }

  void getuserData() async{
    var url =Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_admin_data.php");
   // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_admin_data.php");
    var data = {"admin_id":adminId};
    print(data);
    var response = await http.post(
      url,
     body: data,
     headers: <String, String> {
       'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
     }
     );

     // print(response.body);

    var res = jsonDecode(response.body);

    var admindata = adminDataFromJson(jsonEncode(res['data']));

    var adminmap = admindata.map((e){

        setState(() {
            name = e.name;
            phone = e.phone;
            address = e.address;
            email = e.email;
        });
    });

    print(adminmap);   
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

        appBar: AppBar(
          title:Text(
            'ข้อมูลผู้ใช้'
          ),
          backgroundColor: Colors.blue[400],
          ),
          body: ListView(
            children: <Widget> [
             email == null ? Center(
               child: CircularProgressIndicator(),
             ) : 
             Column(
               children: [
                  textHeader(text: 'ข้อมูลผู้ใช้'),
              adminDataStyle(
                text:'ชื่อ-นามสกุล : '+name,
              ),
              //adminDataStyle(
              //  text:'ที่อยู่ : '+address,
              //),
              adminDataStyle(
                text:'เบอร์โทร : '+phone,
              ),
              adminDataStyle(
                text:'อีเมล : '+email,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical:20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width*0.5,
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: FlatButton(
                  onPressed: () async {

                      SharedPreferences user = await SharedPreferences.getInstance();
                      user.remove('user_id');
                      user.remove('admin_id');
                      user.remove('water_id');
                      user.remove('member_name');
                      user.remove('path');
                      Navigator.pushReplacement(
                        context,
                        PageTransition(child: Confic(), type: PageTransitionType.fade),
                         );


                  },
                  child:Text(
                    'ออกจากระบบ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
               ],
             )
            ],
            ),


    );
      
  }
}

class adminDataStyle extends StatelessWidget {

  final String text;
  const adminDataStyle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Text(
        text,
        style: TextStyle(
          fontSize : 18,
        ),
      ),
    );
  }
}


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rsmart/TypeData/dashBoardData.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/editprofile/edit_profile.dart';
import 'package:rsmart/screen/lastUnit/lastUnit.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:rsmart/screen/pay/pay.dart';
import 'package:rsmart/screen/unPay/unPay.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class Menu extends StatefulWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  var path;

  void initState() {
    super.initState();
    getPath();
  }
  getPath() async{
    SharedPreferences user = await SharedPreferences.getInstance();
      setState(() {
        path = user.getString('path');
        
      });

  }


  Future getDataDashBoard() async {

   //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_profile_show.php");
   var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_profile_show.php");
    //print(url);
    var response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type' : 'application/x-www-form-urlencoded; charset=utf-8',
      }
    );

    if (response.statusCode== 200) {
      return response.body;
    }else{
      return 1;
    }

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.water_damage_outlined) ,
        onPressed: () {

        },
        ),
        title:Text(
          'ระบบประปาเพื่อชมชน',
          style:TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
          backgroundColor: Colors.blue[400],
          actions: <Widget>[
          
          Container(
            margin: EdgeInsets.only(right: 15),
            child: IconButton(
              tooltip: 'บัญชีของคุณ',
              icon:Icon(
                Icons.person,
              ),
              onPressed: () {

                 Navigator.push(
                  context,
                  PageTransition(child: ShowUserData(), type: PageTransitionType.rightToLeft)
                  );

              },
            ) ,
          ),
          ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return Navigator.pushReplacement(context, 
          PageTransition(child:Menu(), type:PageTransitionType.fade ),
          );
        },
        child: ListView(
          children: <Widget> [
            Center(
              child:Column(
                children: <Widget>  [
                  textHeader(
                    text:'เมนูหลัก',
                  ),
                  FutureBuilder(
                    future: getDataDashBoard(),
                    builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
                      if (snapshot.data == 1){
                        return Text('API ERROR');
                      }else if (snapshot.hasData){
                        var res = jsonDecode(snapshot.data);
                        List<DasdBoardData> dashboard = dasdBoardDataFromJson(jsonEncode(res['data']));


                        return Column(
                          children: dashboard.map((e) => 
                          Column(
                            children: [
                              simpleText(
                                text: e.profileName,
                              ),
                              simpleText(
                                text : 'จำนวนผู้ใช้น้ำทั้งหมด  : ${e.member} บ้าน',
                              ),
                              simpleText(
                                text: 'จดค่าน้ำแล้ว : ${e.unitData} บ้าน'
                              ),
                            ],
                          ),
                          ).toList(),
                        );
                      }else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                    ),
                 
                Column(
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 20, 12, 30),
                      child:Center(
                        child:Wrap(
                          spacing: size.width*0.01,
                          runSpacing: size.width*0.01,
                          children: [
                            toolMenu(
                              text: 'บันทึกค่าน้ำ\nปัจจุบัน',
                              img: 'assets/icon/contract.png',
                              press: () {
                                Navigator.push(
                                  context,
                                  PageTransition(child: Dashboard(), type: PageTransitionType.rightToLeft),
                                  );
                              },
                            ),
                            toolMenu(
                              text: 'บันทึกค่าน้ำ\nย้อนหลัง',
                              img:'assets/icon/return.png',
                              press: () {
                                Navigator.push(
                                  context, 
                                  PageTransition(type: PageTransitionType.rightToLeft, child:LastUnit()),
                                  );
                              },
                            ),
                            toolMenu(
                              text: 'รายการชำระเงินแล้ว',
                              img:'assets/icon/doc_blue.png',
                              press: () {
                                Navigator.push(
                                  context,
                                  PageTransition(type: PageTransitionType.rightToLeft, child: Pay() )
                                );
                              },
                              ),
                            toolMenu(
                              text: 'รายการค้างชำระ',
                              img:'assets/icon/doc.png',
                              press: () {
                                Navigator.push(
                                  context,
                                  PageTransition(type: PageTransitionType.rightToLeft, child: UnPay()),
                                );
                              },
                            ),
                            toolMenu(
                              text: 'จัดการข้อมูลองค์กร',
                              img: 'assets/icon/editprofile.png',
                              press: () {
                                Navigator.push(
                                  context,
                                  PageTransition(type: PageTransitionType.fade, child: EditProfile()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      ),
                     
                  ],
                ),
                ],
              ),
            ),
          ],
        ) ,
        ),
    );
  }
}

class simpleText extends StatelessWidget {
  final String text;
  const simpleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      child:Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class toolMenu extends StatelessWidget {
  final String text;
  final img;
  final press;
  const toolMenu({
    Key? key,
    required this.text,
    this.img,
    this.press,
  }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width* 0.45,
      height: size.height*0.27,
      child:Card(
        color: Colors.blue[200],
        child:Center(
          child:Padding(
            padding: EdgeInsets.all(8),
            child: FlatButton(
              onPressed: press,
              child:Column(
                children: [
                  Image.asset(
                    img,
                    height: size.height*0.15,
                    width: size.width*0.2,
                  ),
                  Center(
                    child: Text(
                      text,
                      style:TextStyle(
                        fontSize: 18,
                        fontWeight:FontWeight.bold,
                        color:Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



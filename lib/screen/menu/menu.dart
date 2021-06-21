import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/lastUnit/lastUnit.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:rsmart/screen/pay/pay.dart';
import 'package:rsmart/screen/unPay/unPay.dart';
import 'package:http/http.dart' as http;



class Menu extends StatefulWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  void initState() {
    super.initState();
   // getDashBoardData();
  }

 // void getDashBoardData() async {
//
 //   var url = Uri.parse("https://192.168.43.26/rsmart/api/appApi/User/api_dashboard.php");
 //   
 //   var response = await http.get(
 //     url,
 //     headers: <String, String> {  'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'} 
 //     );
//
 //   print(response.statusCode);
 // }


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
               //   Container(
               //     margin: EdgeInsets.only(top:20),
               //     child:Center(
               //       child: Text(
               //         'จำนวนผู้ใช้ทั้งหมด : ',
               //         style: TextStyle(
               //           fontSize:18,
               //         ),
               //         ),
               //     ),
               //   ),
               //   Container(
               //     child:Center(
               //       child: Text(
               //         'จำนวนที่จดเลขมิตเตอร์แล้ว : ',
               //         style: TextStyle(
               //           fontSize: 18,
               //         ),
               //       ),
               //     ),
               //   ),
                Column(
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 30, 12, 30),
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
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:rsmart/screen/login/login.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Confic extends StatefulWidget {
  const Confic({ Key? key }) : super(key: key);

  @override
  _ConficState createState() => _ConficState();
}

class _ConficState extends State<Confic> {

  var api_path = TextEditingController();

  void check() async {




      var url = Uri.parse("http://demo.rsmartthailand.com/appapi/rsmart/api/appApi/checkConfic/api_test_confic.php");
    //   var url  = Uri.parse("http://192.168.43.26/rsmart/api/appApi/test/api_test_confic.php");

       var data = {"path":api_path.text};

    var response = await http.post(url, body:data, headers: {'Content-Type': 'application/x-www-form-urlencoded;  charset=utf-8'});

    print(response.body);

    if (response.statusCode == 200) {

      print("OK");

        SharedPreferences user = await SharedPreferences.getInstance();
        user.setString('path', api_path.text);

       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('เชื่อต่อสำเร็จ'))
      );

      Navigator.pushReplacement(
        context, 
        PageTransition(type: PageTransitionType.fade , child: Login() ),
        );



    }else {
      
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่พบข้อมูลURLของคุณ'))
      );

    }

    

   

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:ListView(
        children: [
          Center(
            child:Column(
              children: [
                 TextHerder(
                  text:"ประปาเพื่อชมชน"
                ),
               Container(
                 margin:EdgeInsets.all(20),
                 child: Image.asset(
                  'assets/icon/confic.png',
                 width: size.width * 0.5,
                ),
               ),
               inputTextLogin(
                 text: 'url ของคุณ',
                 obscureText: false,
                 icon: Icons.cast_connected,
                 controller: api_path,
                 ),
                Text(
                  'ตัวอย่างการใส่url demo.rsmartthailand.com '
                ),
                RoundBg(
                  color: Colors.blue[300],
                  child: FlatButton(
                    onPressed: () {
                      check();
                    },
                    child:Text(
                      'เชื่อมต่อฐานข้อมูล',
                      style:TextStyle(
                        fontSize: 20,
                        fontWeight:FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                  ),
                
              ],
            )
          )
        ],
      ),
    );
  }
}
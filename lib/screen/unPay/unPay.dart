import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/payData.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UnPay extends StatefulWidget {
  const UnPay({ Key? key }) : super(key: key);

  @override
  _UnPayState createState() => _UnPayState();
}

class _UnPayState extends State<UnPay> {


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



  Future getUnPayData() async {
     var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_get_data_unpay.php");
    //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_get_data_unpay.php");

    var data = {};

    var response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type' : 'application/x-www-form-urlencoded; charset=utf-8'
      }
      );

    //print(response.body);
    
    if (response.statusCode == 200) {
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
        leading:  IconButton(
        icon: Icon(Icons.home) ,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageTransition(child: Menu(), type: PageTransitionType.fade),
          );
        },
        ),
        title:Text(
          'รายการค้างชำระ',
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
        onRefresh: () {
          return
          Navigator.pushReplacement(
            context,
            PageTransition(child:UnPay(), type: PageTransitionType.fade)
          );
        },
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  
                  textHeader(
                    text: 'รายการค้างชำระ'
                    ),

                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(width:1,color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder(
                      future: getUnPayData(),
                      builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
                      if (snapshot.data == 1){
                        return Text(
                          'ไม่มีรายการ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.bold,
                          ),
                          );
                      }
                      else if(snapshot.hasData) {
                        var res = jsonDecode(snapshot.data); 
                        List<PayData> payData = payDataFromJson(jsonEncode(res['data']));
                        
                         return Center(
                           child: Theme(
                             data: Theme.of(context).copyWith(
                                       dividerColor: Colors.blue
                                   ),
                             child: DataTable(
                               columns: [
                                 DataColumn(label: Text('ชื่อ-นามสกุล',style: TextStyle(fontWeight: FontWeight.bold))),
                                 DataColumn(label: Text('จำนวนเงิน',style: TextStyle(fontWeight: FontWeight.bold)))
                               ], 
                               rows: payData.map((e) => 
                               DataRow(
                                 cells: [
                                   DataCell(
                                     Text(e.name,style: TextStyle(fontSize:14)),
                                   ),
                                   DataCell(Text(e.pay, style: TextStyle(fontSize:14))),
                                 ],
                               ),
                               
                               ).toList(),
                               ),
                           ),
                         );
                      }
                      else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                  
                      }
                      ),
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
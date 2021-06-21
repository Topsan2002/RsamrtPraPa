import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/payData.dart';
import 'package:rsmart/TypeData/payTotalData.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 


class Pay extends StatefulWidget {
  const Pay({ Key? key }) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {

  var path;


  //@override
  void initState() {
    super.initState();
    getPath();
  }

 // final StreamController _steam = new StreamController();



  getPath() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
        path = user.getString('path');

    });
  }

  Future getPay() async {
    print('${path} this');
    var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_get_data_pay.php");
   // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_get_data_pay.php");
    var response = await http.get(
      url,
      headers: <String, String> {
         "Content-type": "application/x-www-form-urlencoded; charset=utf-8"
         }
      );

 // print(response.statusCode);
 // print(response.body);
    
    if (response.statusCode == 200) {
      //_steam.sink.add(response.body);
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
          'รายการชำระเงินแล้ว',
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
        onRefresh: 

         () {
           return Navigator.pushReplacement(
             context,
             PageTransition(child: Pay(), type:PageTransitionType.fade ),
           );
         }
         ,
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical:20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width:size.width*0.7,
                    decoration:BoxDecoration(
                      color:Colors.blue[300],
                      borderRadius:BorderRadius.circular(29),
                    ),
                    child: Center(
                      child: Text(
                        'รายการชำระเงินแล้ว',
                        style:TextStyle(
                          fontWeight:FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(color:Colors.blue, width:1),
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: FutureBuilder(
                      future: getPay(),
                      builder: (BuildContext buildcontext, AsyncSnapshot snapshot) {
                          if (snapshot.data == 1){
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                  'ยังไม่มีรายการชำระเงินของเดือนนี้',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ], 
                                  ),
                            );
                          }else if (snapshot.hasData) {
                            var res = jsonDecode(snapshot.data);
      
                            List<PayData> payData = payDataFromJson(jsonEncode(res['data']));
      
                            return Theme(
                              data: Theme.of(context).copyWith(
                                        dividerColor: Colors.blue
                                    ),
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text('ชื่อ-นามสกุล')),
                                  DataColumn(label: Text('จำนวนเงิน'))
                                ], 
                                rows: payData.map((e) => 
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Text(e.name),
                                    ),
                                    DataCell(Text(e.pay)),
                                  ],
                                ),
                                
                                ).toList(),
                                ),
                            );
                          }else{
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
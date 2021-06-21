import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/memberDataTable.dart';
import 'package:rsmart/screen/dashboard/componentes/dashboardStyle.dart';
import 'package:rsmart/screen/dashboard/widget/widgetDashboard.dart';
import 'package:rsmart/screen/dataUser/dataUser.dart';
import 'package:rsmart/screen/manage_unit/manage_unit.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var keyword = TextEditingController();
  int testdata = 0;
  var path;

  final StreamController _stream = new StreamController();

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



  void data() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    var a =  user.getString('admin_id');
    //print('this');
    //print(a);
    //print('thid');
  }


  void getdatamemberpage() {
      //print(keyword.text);
      testdata = testdata + 1; 
    _stream.sink.add(testdata);
  }

  void getWaterId(String waterID, String nameMember) async {
    SharedPreferences member = await SharedPreferences.getInstance();
    member.setString('water_id', waterID);
    member.setString('member_name', nameMember);
    //print(waterID);
     Navigator.push(
      context,
      PageTransition(child: ManageUnit(), type: PageTransitionType.rightToLeft)
      );

  }




  Future getMember() async {
    //print(keyword.text);


    var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_search_member.php");
    // /var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_search_member.php");
    var data = {"keyword": '${keyword.text}'};
    //print(data);
    var response = await http.post(
      url,
      body: data,
      headers: <String, String> {
        'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
      }
      );
  
      
      if(response.statusCode == 200) {
        return response.body;
      }else {
        return response.body;
      }
      
  }

  void nextpage() {
    Navigator.push(
      context,
      PageTransition(child: ManageUnit(), type: PageTransitionType.rightToLeft)
      );
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
          'บันทึกค่าน้ำเดือนปัจจุบัน',
          style:TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
          backgroundColor: Colors.blue[400],
          //actions: <Widget>[
          //
          //Container(
          //  margin: EdgeInsets.only(right: 15),
          //  child: IconButton(
          //    tooltip: 'บัญชีของคุณ',
          //    icon:Icon(
          //      Icons.person,
          //    ),
          //    onPressed: () {
          //       Navigator.push(
          //        context,
          //        PageTransition(child: ShowUserData(), type: PageTransitionType.rightToLeft)
          //        );
          //    },
          //  ) ,
          //),
         // ],
      ),
      body: ListView(
        children: [
             Container(
            child:StreamBuilder(
              stream: _stream.stream,
               builder: (BuildContext buildcontext, AsyncSnapshot snapshot) {
                 print(snapshot.data);
                 if(snapshot.data == null  || snapshot.data == 0) {
                   return dashbordBody(
                            controller: keyword,
                            press: () {
                              getdatamemberpage();
                              getMember();
                              //data();
                              
                              },
                          );
                 }
                 else {
                   return FutureBuilder(
                     future: getMember(),
                     builder: (BuildContext buildcontext, AsyncSnapshot snapshot) {
                       if (snapshot.hasData) {
                            var  res = jsonDecode(snapshot.data);
                            List<MemberDataTable> member = memberDataTableFromJson(jsonEncode(res['data'])); 
                         return Column(
                       children : <Widget> [
                        RoundText(
                          text: 'รายชื่อผู้ใช้น้ำ'
                          ),
                          Container(
                             // margin: EdgeInsets.all(10),
                              width: size.width*0.8,
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                border:Border.all(width: 1, color:Colors.blue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.blue
                                  ),
                                    child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: headerTable(
                                      text:'ชื่อ-นามสกุล'
                                      ),
                                    ),
                                    DataColumn(
                                      label: headerTable(
                                        text:'เลขผู้ใช้น้ำ',
                                      )
                                    ),
                                ],
                                rows: member.map((e) =>
                                 DataRow(
                                   
                                    cells: [
                                      DataCell(
                                        Text(
                                          e.memName,
                                          style: TextStyle(
                                                fontSize:12,
                                              ),
                                          ),
                                          onTap: () {
                                            getWaterId(e.waterId, e.memName);
                                            //nextpage();
                                            //test2('นายคมสัน  ศรีฉ่ำ');
                                          },
                                          ),
                                          DataCell(
                                            Text(
                                              e.waterId,
                                              style: TextStyle(
                                                fontSize:12,
                                              ),
                                            ),
                                            onTap: () {
                                              getWaterId(e.waterId, e.memName);
                                              //nextpage();
                                              //test2('64000205');
                                            }
                                          ),
                                    ],
                                  ),
                                ).toList(),
                            ),
                              ),
                              ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20,top: 20),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical:3),
                            width: size.width*0.4,
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                testdata = 0;
                                _stream.sink.add(testdata);
                              },
                              child:Text(
                                'ย้อนกลับ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                       ], 
                       );

                       }else {
                         return Center(
                           child: CircularProgressIndicator(),
                         );
                       }

                     },
                     
                   );
                 }
               },
            ),
             ),
        ],
      ),

       
    );
  }
}


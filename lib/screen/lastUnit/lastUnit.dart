import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/memberDataTable.dart';
import 'package:rsmart/screen/dashboard/componentes/dashboardStyle.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:rsmart/screen/manage_unit/manage_unit.dart';
import 'package:rsmart/screen/manege_unit_last/manege_unit_last.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LastUnit extends StatefulWidget {
  const LastUnit({Key? key}) : super(key: key);

  @override
  _LastUnitState createState() => _LastUnitState();
}

class _LastUnitState extends State<LastUnit> {
  var path;
  int number = 0;
  int number1 = 0;
  int number2 = 0;
  int number3 = 0;
  int numSteam = 0;
  var mon;
  var date_last;
  //var date;
  final StreamController _stream = new StreamController();

  void initState() {
    super.initState();
    getMon();
    getPath();
  }

  // final StreamController _steam = new StreamController();

  getPath() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      path = user.getString('path');
    });
  }

  void getMon() {
    var a = DateFormat("d/M/y").format(DateTime.now());
    var monNow = DateFormat("M").format(DateTime.now());

    mon = [
      '',
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิหายน',
      'ธันวาคม'
    ];

    if (monNow == "1") {
      number = 1;
    } else if (monNow == "2") {
      number = 2;
    } else if (monNow == "3") {
      number = 3;
    } else if (monNow == "4") {
      number = 4;
    } else if (monNow == "5") {
      number = 5;
    } else if (monNow == "6") {
      number = 6;
    } else if (monNow == "7") {
      number = 7;
    } else if (monNow == "8") {
      number = 8;
    } else if (monNow == "9") {
      number = 9;
    } else if (monNow == "10") {
      number = 10;
    } else if (monNow == "11") {
      number = 11;
    } else {
      number = 12;
    }

    if (number == 1) {
      number1 = number + 11;
      number2 = number + 10;
      number3 = number + 9;
    } else if (number == 2) {
      number1 = number - 1;
      number2 = number + 11;
      number3 = number + 10;
    } else {
      number1 = number - 1;
      number2 = number - 2;
      number3 = number - 3;
    }

    // print(mon[number]);
    // print(mon[number1]);
    // print(mon[number2]);
  }

  void getDate(int data) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    var realDate;
    int date = data + 1;
    //print(data);
    if (date < 10) {
      realDate = '0${date}';
    } else {
      realDate = '${date}';
    }

    if (data < 10) {
      date_last = '0${data}';
    } else {
      date_last = '${data}';
    }
    user.setString('date_last', realDate);

    // Navigator.push(
    //   context,
    //   PageTransition(type: PageTransitionType.leftToRight, child: LastUnitSearch()),
    //   );
    getData();
    numSteam = 1;
    _stream.sink.add(numSteam);
  }

  Future getData() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_search_member_last_use.php");
    // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_search_member_last_use.php");

    var data = {"last_mon": date_last};
    //print(data);

    var response = await http.post(url, body: data, headers: <String, String>{
      "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
    });

    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 1;
    }
  }

  void getWaterId(String waterID, String nameMember) async {
    SharedPreferences member = await SharedPreferences.getInstance();
    member.setString('water_id', waterID);
    member.setString('member_name', nameMember);
    //print(waterID);
    Navigator.push(
        context,
        PageTransition(
            child: ManegeLastUnit(), type: PageTransitionType.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'บันทึกค่าน้ำย้อนหลัง',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: bgWhiteSet(
              child: Column(
                children: [
                  StreamBuilder(
                      stream: _stream.stream,
                      builder:
                          (BuildContext buildcontext, AsyncSnapshot snapshot) {
                        if (snapshot.data == null || snapshot.data == 0) {
                          return Column(
                            children: [
                              textHeader(text: 'บันทึกค่าน้ำย้อนหลัง'),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width * 0.65,
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    getDate(
                                      number1 - 1,
                                    );
                                  },
                                  child: Text(
                                    'ประจำเดือน' + mon[number1],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width * 0.65,
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    getDate(
                                      number2 - 1,
                                    );
                                  },
                                  child: Text(
                                    'ประจำเดือน' + mon[number2],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width * 0.65,
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FlatButton(
                                  onPressed: () {
                                    getDate(number3 - 1);
                                  },
                                  child: Text(
                                    'ประจำเดือน' + mon[number3],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.all(20),
                            child: FutureBuilder(
                                future: getData(),
                                builder: (BuildContext buildcontext,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.data == 1) {
                                    return Column(
                                      children: [
                                        textHeader(
                                          text: 'รายชื่อผู้ใช้น้ำ',
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: Text(
                                            'ไม่มีข้อมูล',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 20, top: 20),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 3),
                                          width: size.width * 0.4,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[200],
                                            borderRadius:
                                                BorderRadius.circular(29),
                                          ),
                                          child: FlatButton(
                                            onPressed: () {
                                              numSteam = 0;
                                              _stream.sink.add(numSteam);
                                            },
                                            child: Text(
                                              'ย้อนกลับ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasData) {
                                    //   print(snapshot.data);
                                    var res = jsonDecode(snapshot.data);
                                    List<MemberDataTable> member =
                                        memberDataTableFromJson(
                                            jsonEncode(res['data']));
                                    return Column(
                                      children: <Widget>[
                                        RoundText(text: 'รายชื่อผู้ใช้น้ำ'),
                                        Container(
                                          // margin: EdgeInsets.all(10),
                                          //width: size.width*0.8,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            border: Border.all(
                                                width: 1, color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                  dividerColor: Colors.blue),
                                              child: DataTable(
                                                columns: [
                                                  DataColumn(
                                                    label: headerTable(
                                                        text: 'ชื่อ-นามสกุล'),
                                                  ),
                                                  DataColumn(
                                                      label: headerTable(
                                                    text: 'เลขผู้ใช้น้ำ',
                                                  )),
                                                ],
                                                rows: member
                                                    .map(
                                                      (e) => DataRow(
                                                        cells: [
                                                          DataCell(
                                                            Text(
                                                              e.memName,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              getWaterId(
                                                                  e.waterId,
                                                                  e.memName);
                                                              //nextpage();
                                                              //test2('นายคมสัน  ศรีฉ่ำ');
                                                            },
                                                          ),
                                                          DataCell(
                                                              Text(
                                                                e.waterId,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ), onTap: () {
                                                            getWaterId(
                                                                e.waterId,
                                                                e.memName);
                                                            //nextpage();
                                                            //test2('64000205');
                                                          }),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 20, top: 20),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 3),
                                          width: size.width * 0.4,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[200],
                                            borderRadius:
                                                BorderRadius.circular(29),
                                          ),
                                          child: FlatButton(
                                            onPressed: () {
                                              numSteam = 0;
                                              _stream.sink.add(numSteam);
                                            },
                                            child: Text(
                                              'ย้อนกลับ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

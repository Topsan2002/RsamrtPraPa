import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsmart/TypeData/memberDataUnit.dart';
import 'package:rsmart/screen/dashboard/dashboard.dart';
import 'package:rsmart/screen/lastUnit/lastUnit.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:rsmart/screen/manage_unit/manage_unit.dart';
import 'package:rsmart/screen/manage_unit/widged/manageWidged.dart';
import 'package:rsmart/screen/manage_unit/widged/widgetInputWaterUnit.dart';
import 'package:rsmart/screen/manage_unit/widged/widgetOtherPay.dart';
import 'package:rsmart/screen/menu/menu.dart';
import 'package:rsmart/test/print.dart';
import 'package:rsmart/test/printbill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ManegeLastUnit extends StatefulWidget {
  const ManegeLastUnit({Key? key}) : super(key: key);

  @override
  _ManegeLastUnitState createState() => _ManegeLastUnitState();
}

class _ManegeLastUnitState extends State<ManegeLastUnit> {
  var path;
  int numSteam = 0;
  var waterId;
  var memName;
  var adminID;
  var date;
  var waterUnit = TextEditingController();
  var otherPayName = TextEditingController();
  var otherPayTotal = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getWaterID();
  }

  _getWaterID() async {
    SharedPreferences member = await SharedPreferences.getInstance();
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      path = user.getString('path');
      waterId = member.getString('water_id');
      memName = member.getString('member_name');
      adminID = user.getString('admin_id');
      date = user.getString('date_last');
      // print('this test'+date);
      //getMemberData();
    });
  }

  Future getMemberData() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_member_data.php");

    // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_member_data.php");

    var data = {"water_id": waterId};
    //print(data);
    var response = await http.post(
      url,
      body: data,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      },
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  final StreamController _stream = new StreamController();

  void saveUnit() {
    numSteam = 1;
    _stream.sink.add(numSteam);
    // print(numSteam);
  }

  void savepayother() {
    numSteam = 4;
    _stream.sink.add(numSteam);
  }

  void saveUnitHost() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_input_unit_last.php");

    // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_input_unit_last.php");

    var data = {
      "unit_input": waterUnit.text,
      "water_id": waterId,
      "admin_id": adminID,
      "last_mon": date
    };

    var response = await http.post(url, body: data, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('??????????????????????????????????????????????????????')));
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: ManageUnit()),
      );
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('?????????????????????????????????????????????????????????')));
    } else if (response.statusCode == 402) {
      _showMyDialog();

      //ScaffoldMessenger.of(context).showSnackBar(
      //const SnackBar(content: Text('???????????????????????????????????????????????????????????????????????????????????????????????????'))
      //);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('????????????????????????????????????????????????????????????????????????????????????????????????')));
    }

    print(response.body);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    '???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? ?'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('?????????'),
              onPressed: () {
                unitMinLast();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('??????????????????'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void unitMinLast() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_input_unit_last_min_last.php");

    var data = {
      "unit_input": waterUnit.text,
      "water_id": waterId,
      "admin_id": adminID,
      "last_mon": date
    };

    var response = await http.post(url, body: data, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('??????????????????????????????????????????????????????')));
      numSteam = 0;
      _stream.sink.add(numSteam);
      // Navigator.pushReplacement(
      //   context,
      //   PageTransition(type: PageTransitionType.rightToLeft, child: ManageUnit()),
      //   );

    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('?????????????????????????????????????????????????????????')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('????????????????????????????????????????????????????????????????????????????????????????????????')));
    }
  }

  void savePayOtherHost() async {
    var url = Uri.parse(
        "http://${path}/appapi/rsmart/api/appApi/User/api_unit_other.php");
    // var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_unit_other.php");
    var data = {
      "unit_other": otherPayName.text,
      "amount_other": otherPayTotal.text,
      "water_id": waterId
    };
    //print(data);
    var response = await http.post(url, body: data, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('??????????????????????????????????????????????????????')));

      numSteam = 0;
      _stream.sink.add(numSteam);
      //   Navigator.pushReplacement(
      //     context,
      //     PageTransition(type: PageTransitionType.rightToLeft, child: ManageUnit()),
      //     );
//
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('???????????????????????????????????????????????????????????????????????????')));
    }

    //print(response.statusCode);
    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(child: Menu(), type: PageTransitionType.fade),
            );
          },
        ),
        title: Text(
          '???????????????????????????????????????????????????????????????????????????',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[400],
        //actions: <Widget>[
        //
        //Container(
        //  margin: EdgeInsets.only(right: 15),
        //  child: IconButton(
        //    tooltip: '?????????????????????????????????',
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
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: ManegeLastUnit()),
          );
        },
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  FutureBuilder(
                      future: getMemberData(),
                      builder:
                          (BuildContext buildcontext, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var res = jsonDecode(snapshot.data);
                          List<MemberDataUnit> memData =
                              memberDataUnitFromJson(jsonEncode(res['data']));

                          return Column(
                            children: memData
                                .map(
                                  (e) => Column(
                                    children: [
                                      textHeader(
                                        text: '?????????????????????????????????????????????',
                                      ),
                                      textDataUser(
                                          text: '????????????-????????????????????? : ${memName}'),
                                      textDataUser(
                                          text:
                                              '???????????????????????????????????????????????? :  ${e.unit}'),
                                      textDataUser(
                                          text:
                                              '???????????????????????????????????????????????? : ${e.totalPay} ?????????'),
                                      textDataUser(text: '??????????????? : ${e.status}'),
                                    ],
                                  ),
                                )
                                .toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  StreamBuilder(
                      stream: _stream.stream,
                      builder:
                          (BuildContext buildcontext, AsyncSnapshot snapshot) {
                        if (snapshot.data == null || snapshot.data == 0) {
                          return Column(
                            children: [
                              toolDashboardUnit(
                                press1: () {
                                  saveUnit();
                                },
                                press2: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: PrintTest()),
                                  );
                                },
                                press3: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: PrintReciveBin()),
                                  );
                                },
                                press4: () {
                                  savepayother();
                                },
                              ),
                              buttonCallBack(press: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: LastUnit()),
                                );
                              }),
                            ],
                          );
                        } else if (snapshot.data == 1) {
                          return inputUnitWater(
                            pressSave: () {
                              saveUnitHost();
                            },
                            pressCallBack: () {
                              numSteam = 0;
                              _stream.sink.add(numSteam);
                              // Navigator.push(
                              //      context,
                              //      PageTransition(type: PageTransitionType.rightToLeft, child: ManageUnit()),
                              //    );
                            },
                            controller: waterUnit,
                          );
                        } else if (snapshot.data == 4) {
                          return otherPay(
                              controllerPayName: otherPayName,
                              controllerPayTotal: otherPayTotal,
                              pressSave: () {
                                savePayOtherHost();
                              },
                              pressCallBack: () {
                                numSteam = 0;
                                _stream.sink.add(numSteam);
                                //  Navigator.pushReplacement(
                                //  context,
                                //  PageTransition(type: PageTransitionType.rightToLeft, child: ManageUnit()),
                                //  );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue[200],
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

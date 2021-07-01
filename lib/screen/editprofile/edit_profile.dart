
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rsmart/TypeData/dataProfile.dart';
import 'package:rsmart/TypeData/dataProvince.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  var path;

  void initState() {
    super.initState();
    getPath();
  }
  getPath() async{
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      path = user.getString('path');
       dataAll();
    });

  }


  var aProfileName;
  var aProfileSub;
  var aAddress;
  var aTombon;
  var aUmpher;
  var aProvince;
  var aZipcode;
  var aPhone;
  var aFax;
  var aEmail;
  var aVat;
  var aNameAdmin;
  var aSuport;
  var aProvinceCode;

   var dropdownValue;
  var profileName = TextEditingController();
  var profile = TextEditingController();
  var address = TextEditingController();
  var tombon = TextEditingController();
  var umpher = TextEditingController();
  var province = TextEditingController();
  var zipcode = TextEditingController();
  var phone = TextEditingController();
  var fax = TextEditingController();
  var email = TextEditingController();
  var vat = TextEditingController();
  var nameAdmin = TextEditingController();
  var support = TextEditingController();
  
  void dataAll() async {

    
    var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_get_profile.php");
   //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_get_profile.php");


    var response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type' : 'application/x-www-form-urlencoded; charset=utf-8'
      }
      );

     // print(response.body);

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        var  profile_ = dataProfileFromJson(jsonEncode(res['data']));

        var a = profile_.map((e) {
          setState(() {
          aProfileName = e.profileName;
          aProfileSub = e.profileSub;
          aAddress = e.address;
          aTombon = e.tombon;
          aUmpher = e.umpher;
          aProvince = e.province;
          aZipcode = e.zipcode;
          aPhone = e.phone;
          aFax = e.fax;
          aEmail = e.email;
          aVat = e.vat;
          aNameAdmin = e.manager;
          aSuport = e.service;
          aProvinceCode = e.provinceCode;
          //dropdownValue = e.province;
          });
        }
        );
        print(a);

      }else{
        aProfileName = 1;
        print(response.statusCode);
      }


  }
  
 



  void getAllData() {

    print(profileName.text);
    print(profile.text);
    print(address.text);
    print(tombon.text);
    print(umpher.text);
    print(province.text);
    print(zipcode.text);
    print(phone.text);
    print(fax.text);
    print(email.text);
    print(vat.text);
    print(nameAdmin.text);
    print(support.text);


  }

  void editProfile() async {
    var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_edit_profile.php");
    //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_edit_profile.php");
    var data;
    if (dropdownValue == null) {
       data = {"profile_name": profileName.text, "profile_sub": profile.text, "address": address.text, "tombon": tombon.text, "umpher": umpher.text, "province":aProvinceCode, "zipcode": zipcode.text, "phone": phone.text, "fax": fax.text, "email":email.text, "vat":vat.text, "manager": nameAdmin.text, "service": support.text };
    }else{
      data = {"profile_name": profileName.text, "profile_sub": profile.text, "address": address.text, "tombon": tombon.text, "umpher": umpher.text, "province":dropdownValue, "zipcode": zipcode.text, "phone": phone.text, "fax": fax.text, "email":email.text, "vat":vat.text, "manager": nameAdmin.text, "service": support.text };
    }
   
   // print(data);

    var response = await http.post(
      url,
      body: data,
      headers: <String, String> {
        'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8'
      }
      );

    if (response.statusCode == 200) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('แก้ไขข้อมูลสำเร็จ'))
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('แก้ไขข้อมูลไม่สำเร็จ API ERROR'))
      );
    }

  }



  void test() {
    print(dropdownValue);
  }
  Future getProvince() async {
    var url = Uri.parse("http://${path}/appapi/rsmart/api/appApi/User/api_province.php");
    //var url = Uri.parse("http://192.168.43.26/rsmart/api/appApi/User/api_province.php");

    var response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type' : 'application/x-www-form-urlencoded; charset=utf-8',
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
        title:Text(
          'จัดการข้อมูลองค์กร',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: Colors.blue[400],
      ),
      body: aSuport == null ? Center(child: CircularProgressIndicator(),) : aSuport == 1 ? Center(child:Text('API ERROR ')) : 
          ListView(
        children: <Widget> [
        
               // textHeader(
               //   text: 'จัดการข้อมูลองค์กร'
               //   ),
              Container(
                margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color:Colors.blue[300],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Center(
                  child: Text(
                    'จัดการข้อมูลองค์กร',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                    )
                    ),
                ),
              ),
              headerProfile(
                text:'ชื่อหน่วยงาน',
              ),
              textBodyProfile(
                text : aProfileName,
                controller:  profileName,
                ),
              headerProfile(
                text:'ชื่อย่อหน่วยงาน',
              ),
              textBodyProfile(
                text : aProfileSub,
                controller:  profile,
                ),
              headerProfile(
                text:'ที่ตั้ง',
              ),
             textBodyProfile(
                text : aAddress,
                controller: address,
                          //controller:  profileName,
          ),
              rowTwin(
                text1:'ตำบล/แขวง',
                text2: aTombon,
                controller1: tombon,
                text3: 'อำเภอ',
                text4: aUmpher,
                controller2: umpher,
              ),
              Row(
                children: <Widget> [
                  Expanded(
                    child: Wrap(
                      
                      children: [
                        headerProfile(
                          text : 'จังหวัด'
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20,10,20,0),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FutureBuilder(
                            future:getProvince(),
                            builder: (BuildContext borderRadius, AsyncSnapshot snapshot) {
                              if (snapshot.data == 1){
                                return Text('API PROVINCE ERROR');
                              }else if (snapshot.hasData){
                                var res = jsonDecode(snapshot.data);
                                List<DataProvince> province = dataProvinceFromJson(jsonEncode(res['data']));
                                return new DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: const Icon(Icons.arrow_drop_down_rounded),
                                          iconSize: 24,
                                          elevation: 20,
                                          style: const TextStyle(color: Colors.black),
                                        // underline: Underline.none,
                                          //  height: 3,
                                          //  color: Colors.deepPurpleAccent,
                                          
                                          hint:Text(
                                            aProvince,
                                            style: TextStyle(
                                              fontSize: 18,
                                              
                                            ),
                                            ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                              test();
                                            });
                                          },
                                          items: province.map((e) => 
                                          DropdownMenuItem<String>(
                                              value: e.provinceCode,
                                              child: Text(e.provinceName),
                                            )
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
                 
                  Expanded(
                    child: Wrap(
                      children: [
                        headerProfile(
                          text:'รหัสไปรษณีย์',
                        ),
                        textBodyProfile(
                          text : aZipcode,
                          controller: zipcode,
                          //controller:  profileName,
                          ),
                      ],
                    ),
                  ),
                ]
              ),
               rowTwin(
                    text1: 'เบอร์โทร',
                    text2:  aPhone,
                    controller1: phone,
                    text3: 'แฟ๊ก/FAX',
                    text4: aFax,
                    controller2: fax,
                  ),
              headerProfile(
                text: 'E-mail',
              ),
              textBodyProfile(
                text : aEmail,
                controller: email,
              ),
              headerProfile(
                text:'เลขประจำตัวผู้เสียภาษี',
              ),
              textBodyProfile(
                text: aVat,
                controller: vat,
              ),
              headerProfile(
                text:'ชื่อผู้จัดการ',
              ),
              textBodyProfile(
                text: aNameAdmin,
                controller: nameAdmin,
              ),
              headerProfile(
                text: 'ค่าบริการขั้นต่ำ'
              ),
              textBodyProfile(
                text: aSuport,
                controller:support,
                ),
              //headerProfile(
              //  text: 'เบอร์โทร'
              //),
              //textBodyProfile(
              //  text : '085-4725-152'
              //),
              //headerProfile(
              //  text: 'แฟ๊ก/FAX',
              //),
              //textBodyProfile(
              //  text : '085-4725-152'
              //),
             Container(
                margin: EdgeInsets.fromLTRB(70,20,70,20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical:7),
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(29),
                ),
                child:FlatButton(
                  onPressed:() {
                    editProfile();
                    //getAllData();
                  },
                  child: Center(
                    child: Text(
                      'บันทึก',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      ) ,
                    ),
                ),
              ),
              ],
              ),
          
       
    );
  }
}

class rowTwin extends StatelessWidget {
  final text1;
  final text2;
  final text3;
  final text4;
  final controller1;
  final controller2;
  const rowTwin({
    Key? key,
    required  this.text1,
    required  this.text2,
    required  this.text3,
    required  this.text4,
    this.controller1,
    this.controller2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: <Widget> [                 
        Expanded(
          child: Wrap(
            children: [
              headerProfile(
                text:text1,
              ),
              textBodyProfile(
                text : text2,
                controller: controller1,
                //controller:  profileName,
                ),
            ],
          ),
        ),
        Expanded(
          child: Wrap(
            children: [
              headerProfile(
                text: text3,
              ),
              textBodyProfile(
                text : text4,
                controller: controller2,
                //controller:  profileName,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class textBodyProfile extends StatelessWidget {
  final String text;
  final controller;
  const textBodyProfile({
    Key? key,
    required this.text,
    this.controller,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20,10,20,0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child:TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText:text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class headerProfile extends StatelessWidget {
  final String text;
  const headerProfile({
    required  this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20,20,20,0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:18,
        ),
        )
    );
  }
}

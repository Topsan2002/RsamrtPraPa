import 'package:flutter/material.dart';
import 'package:rsmart/screen/dashboard/componentes/dashboardStyle.dart';



class dashbordBody extends StatelessWidget {

  final controller;
  final press;
  const dashbordBody({
    Key? key,
    required this.controller,
    this.press,
  });
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
            child: Column(
        children: <Widget>[ 
          RoundText(
            text:'ค้นหาผู้ใช้น้ำ',
          ),
          Container(
            margin: EdgeInsets.only(top:0, bottom:0),
            child:Image.asset(
              'assets/icon/water.png',
              height: size.height*0.5,
              width: size.width*0.5,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: size.width*0.9,
              decoration: BoxDecoration(
                color:Colors.blue[50],
                borderRadius:BorderRadius.circular(29),
              ),
              child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'กรอกคำค้นที่ต้องการ เช่น เลขผู้ใช้น้ำ เลขมาตรน้ำ เบอร์โทรศัพท์ บ้านเลขที่',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical:5),
            width:size.width*0.5,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius:BorderRadius.circular(29),
            ),
            child:FlatButton(
              onPressed: press,
              child: Text(
                'ค้นหาข้อมูล',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


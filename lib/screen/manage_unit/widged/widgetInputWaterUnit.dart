import 'package:flutter/material.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';


class inputUnitWater extends StatelessWidget {

  final pressCallBack;
  final pressSave;
  final controller;


  const inputUnitWater({
    Key? key,
    required this.pressSave,
    this.pressCallBack,
    this.controller,
  });

 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
          children : [
            textHeader(
             text: 'บันทึกการใช้น้ำ'
            ),
            Container(
              margin: EdgeInsets.only(top:20),
              child: Image.asset(
                'assets/icon/contract.png',
                height: size.height*0.1,
                width: size.width*0.3,
              ),
            ),
            inputNumber(
              hintText:'ตัวเลขมาตรน้ำเดือนปัจจุบัน', 
              controller: controller
              ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                        child: buttonCallBack(
                        press: pressCallBack,
                        ),
                    ),
                    Expanded(
                        child:buttonSave(
                          press: pressSave
                          ),
                    ),
                ],
              ),
            ),
          ], 
    );
  }
}
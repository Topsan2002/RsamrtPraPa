import 'package:flutter/material.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';



class otherPay extends StatelessWidget {

  final pressCallBack;
  final pressSave;
  final controllerPayName;
  final controllerPayTotal;

  const otherPay({
    Key? key,
    this.pressCallBack,
    this.pressSave,
    this.controllerPayName,
    this.controllerPayTotal,
  });


 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget> [
        textHeader(
          text: 'ค่าบริการอื่นๆ'
          ),
          Container(
            child: Image.asset(
              'assets/icon/tool.png',
              width:size.width*0.3,
              height:size.height*0.1,
            ),
          ),
          RoundBg(
            color:Colors.blue[50],
            child: TextField(
              controller: controllerPayName,
              decoration: InputDecoration(
                hintText: 'รายละเอียดค่าใช่จ่ายอื่นๆ',
                border: InputBorder.none,
              ),
            ),
            ),
            inputNumber(
              controller: controllerPayTotal,
              hintText:'จำนวนเงิน',
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                          child: buttonCallBack(
                          press: pressCallBack
                          ),
                      ),
                      Expanded(
                          child:buttonSave(
                            press: pressSave,
                            ),
                      ),
                  ],
                ),
              ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:rsmart/screen/login/componentes/loginStyle.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';




class toolDashboardUnit extends StatelessWidget {
  final press1;
  final press2;
  final press3;
  final press4;

  const toolDashboardUnit({
    required this.press1,
    required this.press2,
    required this.press3,
    required this.press4,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 20,
          children: [
            buttonManage(
              text:'บันทึกการใช้น้ำ',
              img: 'assets/icon/contract.png',
              press: press1,
            ),
            buttonManage(
              text:'แจ้งค่าน้ำ',
              img: 'assets/icon/bill.png',
              press: press2,
            ),
            buttonManage(
              text:'ใบเสร็จรับเงิน',
              img: 'assets/icon/printer.png',
              press: press3,
            ),
            buttonManage(
              text:'ค่าบริการอื่นๆ',
              img: 'assets/icon/tool.png',
              press: press4,
            ),
        ],),
      ),
      );
  }
}


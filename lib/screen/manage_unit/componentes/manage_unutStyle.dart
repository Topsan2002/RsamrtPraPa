import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class buttonCallBack extends StatelessWidget {
  final press;
  const buttonCallBack({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      width: size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(29),
      ),
      child: FlatButton(
        onPressed: press,
        child: Text(
          'ย้อนกลับ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class textHeader extends StatelessWidget {
  final String text;
  const textHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 5.h,
      ),
      width: size.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(29),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class textDataUser extends StatelessWidget {
  final String text;
  const textDataUser({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}

class buttonManage extends StatelessWidget {
  final String text;
  final press;
  final img;

  const buttonManage({
    Key? key,
    required this.text,
    this.press,
    this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.45,
      height: size.height * 0.27,
      child: Card(
        color: Colors.blue[200],
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FlatButton(
              onPressed: press,
              child: Column(
                children: [
                  Image.asset(
                    img,
                    height: size.height * 0.15,
                    width: size.width * 0.2,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class inputNumber extends StatelessWidget {
  final controller;
  final hintText;

  const inputNumber({
    Key? key,
    required this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}

class buttonSave extends StatelessWidget {
  const buttonSave({
    Key? key,
    required this.press,
  }) : super(key: key);

  final press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      width: size.width * 0.01,
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadius.circular(29),
      ),
      child: FlatButton(
        onPressed: press,
        child: Text(
          'บันทึก',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

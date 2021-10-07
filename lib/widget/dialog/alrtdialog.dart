import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class dialogAlert extends StatelessWidget {
  final String text;
  final img;
  const dialogAlert({
    Key? key,
    required this.text,
    this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.r),
      ),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.h,
        ),
        height: 170.h,
        width: 300.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Center(
                child: Image.asset(
                  img,
                  height: 72.h,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class alertdialogConfirmDetial extends StatelessWidget {
  final press;
  final String title;
  final String detial;
  const alertdialogConfirmDetial({
    Key? key,
    required this.title,
    required this.detial,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      titleTextStyle: TextStyle(
        fontFamily: 'kanit',
        fontSize: 16.sp,
        color: Colors.black,
      ),
      content: Container(
        height: 50.h,
        width: 300.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                detial,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 5.h,
          ),
          color: HexColor("#1DAE46"),
          textColor: Colors.white,
          child: Text(
            'ตกลง',
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
          onPressed: press,
        ),
        FlatButton(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 5.h,
          ),
          color: Colors.red,
          textColor: Colors.white,
          child: Text('ยกเลิก',
              style: TextStyle(
                fontSize: 12.sp,
              )),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

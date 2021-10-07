import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class menuitem extends StatelessWidget {
  final String text;
  final press;
  final img;
  const menuitem({
    Key? key,
    required this.text,
    required this.img,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: press,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: ListTile(
          leading: Image.asset(
            img,
            height: 40.h,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class simpleText extends StatelessWidget {
  final String text;
  const simpleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
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

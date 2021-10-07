import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class textformVaridate extends StatelessWidget {
  final name;
  final String text;
  final icon;
  final obscureText;

  const textformVaridate({
    Key? key,
    required this.name,
    required this.text,
    this.icon,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 14.sp,
      ),
      validator: FormBuilderValidators.compose([
        (val) {
          if (val == null || val == '') {
            return "กรุณณากรอกข้อมูลให้ครบถ้วน";
          } else {
            return null;
          }
        }
      ]),
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints(
          minHeight: 20.h,
          minWidth: 20.h,
        ),
        suffixIcon: Container(
          margin: EdgeInsets.only(right: 10.h),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 24.sp,
          ),
        ),
        // filled: true,
        // fillColor: Colors.blue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.sp,
          ),
        ),
        errorStyle: TextStyle(fontSize: 12.sp),
        //isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 7.h,
          vertical: 7.h,
        ),
        hintText: text,
        hintStyle: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class unitformVaridate extends StatelessWidget {
  final name;
  final String text;

  const unitformVaridate({
    Key? key,
    required this.name,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 14.sp,
      ),
      validator: FormBuilderValidators.compose([
        (val) {
          if (val == null || val == '') {
            return "กรุณณากรอกข้อมูลให้ครบถ้วน";
          } else {
            return null;
          }
        }
      ]),
      decoration: InputDecoration(
        // filled: true,
        // fillColor: Colors.blue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.sp,
          ),
        ),
        errorStyle: TextStyle(fontSize: 12.sp),
        //isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 7.h,
          vertical: 7.h,
        ),
        hintText: text,
        hintStyle: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

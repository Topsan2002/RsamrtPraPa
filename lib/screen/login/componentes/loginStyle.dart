import 'package:flutter/material.dart';



class inputTextLogin extends StatelessWidget {

  final String text;
  final controller;
  final obscureText;
  final icon;

  const inputTextLogin({
    Key? key,
    required this.text,
    this.controller,
    this.obscureText,
    this.icon,
  }) ;



  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return RoundBg(
      color:Colors.blue[50],
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon:Icon(
            icon,
            color: Colors.blue[300],
            ),
          hintText: text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundBg extends StatelessWidget {
  final child;
  final color;

  const RoundBg({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical:10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical:5),
      width: size.width*0.7,
      decoration: BoxDecoration(
        color: color,
        //border: Border.all(width:100),
        borderRadius:BorderRadius.circular(29),
      ),
      child:child,
    );
  }
}

class TextHerder extends StatelessWidget {
  final String text;
  const TextHerder({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:70),
      padding: EdgeInsets.symmetric(horizontal:30, vertical:10),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius:BorderRadius.circular(29),
      ),
      child: Text(
        text,
        style:TextStyle(
          fontSize:30,
          fontWeight:FontWeight.bold,
          color:Colors.white,
        ),
        ),
        );
  }
}

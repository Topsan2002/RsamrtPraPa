import 'package:flutter/material.dart';


class RoundText extends StatelessWidget {
  final String text;
  const RoundText({
    Key? key,
    required this.text,
    
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top:25, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal:20, vertical:8),
      width: size.width*0.6,
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(29),
      ),
      child:Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}



class headerTable extends StatelessWidget {
  final String text;
  const headerTable({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      );
  }
}
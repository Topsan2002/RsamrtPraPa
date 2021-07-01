import 'package:flutter/material.dart';
import 'package:rsmart/screen/manage_unit/componentes/manage_unutStyle.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'จัดการข้อมูลองค์กร',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: Colors.blue[400],
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: <Widget> [
                textHeader(
                  text: 'จัดการข้อมูลองค์กร'
                  ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom:10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: size.width*0.4,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Center(
                    child: Text(
                      'ชื่อองกรณ์',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      ),
                      ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:20,right: 20, bottom:10),
                padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
                width: size.width*0.8,
                decoration:BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                   // labelText: 'ชื่อองกรณ์',
                    hintText: 'ชื่อองกรณ์',
                    border: InputBorder.none,
                  ),
                ),
              ),
              ],
              ),
          )
        ],
      ),
    );
  }
}
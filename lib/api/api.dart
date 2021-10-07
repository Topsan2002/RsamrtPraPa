import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<String> api() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    var path = user.getString('path');
    // print(path);
    var data = 'http://${path}/appapi/rsmart/api/appApi/User/';
    //print(data);
    return data;
  }
}

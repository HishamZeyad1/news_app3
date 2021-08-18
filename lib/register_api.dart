import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/CacheHelper.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterAPI {

  Future<bool> register(String name , String email , String password ) async {
    String registerapi = "http://192.168.252.237:8000/api/register";
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/json"
    };

    Map body = {
      "name":name,
      "email" : email,
      "password" : password
    };
    var url = Uri.parse(registerapi);
    print(url);
    var response = await http.post( url,headers: headers, body: body );
    print(response);
    print(response.statusCode);

    if( response.statusCode == 200||response.statusCode == 201 ){
      try{
        var jsonData = jsonDecode( response.body);
        var data = jsonData['data'];
        var token = data['token'];
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        CacheHelper.putbool(key: "token", value: true);
        return true;
      }catch( Exception ){
        print(Exception.toString());
        return false;
      }

    }

    return false;
  }

}
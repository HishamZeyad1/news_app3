import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/CacheHelper.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationAPI {

  Future<bool> login( String email , String password ) async {
    String authApi = "https://newsapp-api2.herokuapp.com" + "/api/token";
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded"
    };
    Map<String,String> body = {
      "email" : email,
      "password" : password
    };
    var url = Uri.parse(authApi);

    var response = await http.post( url , headers: headers , body: body );

    if( response.statusCode == 200 ){
      try{
        var jsonData = jsonDecode( response.body);
        var data = jsonData['data'];
        var token = data['token'];
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        CacheHelper.putbool(key: "token", value: true);
        return true;
      }catch( Exception ){
        return false;
      }

    }

    return false;
  }

}
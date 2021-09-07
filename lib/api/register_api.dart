import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/CacheHelper.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterAPI {



  Future<bool> register(String name , String email , String password ) async {
    String registerapi =base_api+register_api ;//"http://localhost:8000/api/register"
    String authApi = base_api+auth_api;
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded"
    };
    // Map<String,String> headers= {
    //   "Accept": "application/json",
    //   "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    // "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
    // "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    // "Access-Control-Allow-Methods": "POST, OPTIONS"
    // };
    Map body = {
      "name":name,
      "email" : email,
      "password" : password
    };

    var url = Uri.parse(registerapi);
    print(url);
    var response = await http.post( url,headers:headers , body: body );
    print(response);
    print(response.statusCode);

    if( response.statusCode == 200||response.statusCode == 201 ){
      try{
        print("**********Done**************");
        var jsonData = jsonDecode( response.body);
        var data = jsonData['data'];
        print("**********data**************");
        print(data);
        // var token = data['token'];
        // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        // sharedPreferences.setString("token", token);
        // CacheHelper.putbool(key: "token", value: true);
        return true;
      }catch( Exception ){
        print("EXEPTION DUE TO REGISTRATION");
        print(Exception.toString());
        return false;
      }

    }

    return false;
  }

}
import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/CacheHelper.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationAPI {

  Future<bool> login( String email , String password ) async {
    String authApi = base_api+auth_api;
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
    print(response.statusCode);
    print(response.body);

    if( response.statusCode == 200 ||response.statusCode == 201 ){
      try{
        print("****************Done********************");
        print(response.body);
        var jsonData = jsonDecode( response.body);
        // print(response.body);

        var data = jsonData['token'];
        var token = data['token'];
        print("****************token********************");
        print(token);
        var name=jsonData['user']['name'];
        var email=jsonData['user']['email'];
        var avatar=jsonData['user']['avatar'];
        print("************user************************");
        print("name:$name");print(email);print(avatar);

        // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        // sharedPreferences.setString("token", token);
        CacheHelper.putbool(key: "token", value: true);
        CacheHelper.putstring(key: "tokenStr", value: token);
        CacheHelper.putstring(key: "name", value: name);
        CacheHelper.putstring(key: "email", value: email);
        CacheHelper.putstring(key: "avatar", value: avatar);
        return true;
      }catch( Exception ){
        print(Exception.toString());
        return false;
      }

    }

    return false;
  }

}
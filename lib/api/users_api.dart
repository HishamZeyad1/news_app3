import 'dart:convert';

import 'package:logout_problem_solution/models/user.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';
import 'package:http/http.dart' as http;

class UsersAPI {
  User? user=null;
  Future<User?> fetChUsersByCommentId( String id,bool domain1) async {
    //print("******************************************");
    String authorApi;
    if(domain1==true){
      authorApi = base_api1 + User_api + id ;
    }else{
      authorApi = base_api + User_api + id ;
    }
    // String authorApi = base_api + Author_api + id;
    var url = Uri.parse(authorApi);
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded"
    };
    var response = await http.get(url,headers:headers);
    // print("response.statusCode:"+response.statusCode.toString());
    // print("response.body:"+response.body.toString());
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      print(jsonData);

      // print("*********data***********");
      // print(data[0].toString());
      // print("***********data*********");

      // for (var item in data) {
      user = User(id: jsonData['id'].toString(),
          name: jsonData['name'].toString(),
          email: jsonData['email'].toString(),
          avatar: jsonData['avatar'].toString());

      // }
      // print("++++++++++++++++++++++++++"+author.toString());
    }
    return user;
  }

}
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logout_problem_solution/models/author.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';


class AuthorsAPI {

  Future<List<Author>> fetchAllAuthors(bool domain1) async {
    List<Author> authors = <Author>[];
    String allAuthorsApi;
    if(domain1==true){
      allAuthorsApi = base_api1 + Author_api ;
    }else{
      allAuthorsApi = base_api + Author_api ;
    }

    // String allAuthorsApi = base_api + all_authors_api;
    var url = Uri.parse(allAuthorsApi);
    var response = await http.get(url);
    // var url = Uri.parse(allAuthorsApi); print("*****************");//192.168.42.6
    // var response = await http.get(url);    // var response = await http.get(allAuthorsApi);
    // print(response.statusCode);    print("*****************"); print(response.body);//192.168.42.6\newsapp_api/public/api/authors

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        Author author = Author(id:item['id'].toString(),name:item['name'].toString(),
            // email:item['email'].toString(),
            avatar:item['avatar'].toString());
        authors.add(author);
      }
    }

    return authors;
  }


  Future<Author> fetChAuthorsByPostId( String id,bool domain1) async {
    //print("******************************************");
    String authorApi;
    if(domain1==true){
      authorApi = base_api1 + Author_api + id ;
    }else{
      authorApi = base_api + Author_api + id ;
    }
    // String authorApi = base_api + Author_api + id;
    var url = Uri.parse(authorApi);
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded"
    };
    var response = await http.get(url,headers:headers);
    Author author=new Author(id:"1", name:"Hisham zed",avatar: "ffflflf");
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
        author = Author(id: jsonData['id'].toString(),
            name: jsonData['name'].toString(),
            // email: jsonData['email'].toString(),
            avatar: jsonData['avatar'].toString());

      // }
      // print("++++++++++++++++++++++++++"+author.toString());
    }
    return author;
  }

}
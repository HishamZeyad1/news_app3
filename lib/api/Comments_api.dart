import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/models/comment.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';

import '../CacheHelper.dart';

class CommentsAPI{

  late List<Comment> Comments;
  late int len;
  var token=CacheHelper.getstring(key: "tokenStr");

  Future<List<Comment>> fetChCommentsByPostId( String id,bool domain1 ) async {
    String NewCommentApi;
    if(domain1==true){
      NewCommentApi = base_api1 + Comments_api + id;
    }else{
      NewCommentApi = base_api + Comments_api + id;
    }
    print("*************NewCommentApi******************");

    // String NewCommentApi = base_api + Comments_api + id;
    var url = Uri.parse(NewCommentApi);
    var response = await http.get(url);
     Comments = <Comment>[];
    print(response.statusCode);

    if (response.statusCode == 200||response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      print(data);

      for (var item in data) {
        Comment comment = Comment(
            id: item["id"].toString(),
            content: item["content"].toString(),
            dateWritten: item["date_written"].toString(),
            userId: item["user_id"].toString(),
            postId: item["post_id"].toString()
        );
        Comments.add(comment);
        print("Comment:"+comment.toString());
      }
    }
    print("end of comment api:$Comments");
    return Comments;

  }
  Future<Comment?> addComment( String Postid,String Content,bool domain1 ) async {
    String NewCommentApi;
    if(domain1==true){
      NewCommentApi = base_api1 + AddComments_api;
    }else{
      NewCommentApi = base_api + AddComments_api;
    }
    print("*************addCommentApi******************");

    Map<String,String> body = {
      "content" : Content,
      "post_id" : Postid
    };
    Map<String,String>headers= {
     'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
    };

    // String NewCommentApi = base_api + Comments_api + id;
    var url = Uri.parse(NewCommentApi);
    var response = await http.post(url,headers: headers,body: body);
    // Comments = <Comment>[];
    // print(response.statusCode);
    Comment? comment;
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200||response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      // var data = jsonData["data"];
      print("jsonData:");
      print(jsonData);

      // for (var item in data) {
        comment = Comment(
            id: jsonData["id"].toString(),
            content: jsonData["content"].toString(),
            dateWritten: jsonData["date_written"].toString(),
            userId: jsonData["user_id"].toString(),
            postId: jsonData["post_id"].toString()
        );
        // Comments.add(comment);
        print("Comment:"+comment.toString());
      }
    return comment;
    }

  }

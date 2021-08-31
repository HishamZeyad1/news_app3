import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/models/comment.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';

class CommentsAPI{

  late List<Comment> Comments;
  late int len;
  Future<List<Comment>> fetChCommentsByPostId( String id,bool domain1 ) async {
    String NewCommentApi;
    if(domain1==true){
      NewCommentApi = base_api1 + Comments_api + id;
    }else{
      NewCommentApi = base_api + Comments_api + id;
    }

    // String NewCommentApi = base_api + Comments_api + id;
    var url = Uri.parse(NewCommentApi);

    var response = await http.get(url);
     Comments = <Comment>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];

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
    return Comments;
  }

  int getSize(){
      this.len=Comments.length;
    return len;
  }

}
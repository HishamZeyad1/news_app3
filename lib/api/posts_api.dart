import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logout_problem_solution/models/PostDetails.dart';
import 'package:logout_problem_solution/models/author.dart';
import 'package:logout_problem_solution/models/category.dart';
import 'dart:convert';

import 'package:logout_problem_solution/models/post.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';

class PostsAPI {
  Future<List<Post>> fetChPostsByCategoryId( String id,bool domain1,int postview) async {
    //print("******************************************");
    String whatsNewApi,postsViewByCategory_api;
    switch(postview){
      case 1:postsViewByCategory_api=latestPosts_api;break;
      case 2:postsViewByCategory_api=oldestPosts_api;break;
      case 3:postsViewByCategory_api=voteUpPosts_api;break;
      case 4:postsViewByCategory_api=voteDownPosts_api;break;
      default:postsViewByCategory_api=latestPosts_api;break;
    }
    if(domain1==true){
       whatsNewApi = base_api1 + postsViewByCategory_api + id;
    }else{
       whatsNewApi = base_api + postsViewByCategory_api + id;
    }
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded"
    };

    var url = Uri.parse(whatsNewApi);
    var response = await http.get(url,headers:headers);
    List<Post> posts = <Post>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      //print(response.body);
      for (var item in data) {
        Post post = Post(
            id: item["id"].toString(),
            title: item["title"].toString(),
            content: item["content"].toString(),
            dateWritten: item["date_written"].toString(),
            featuredImage: item["featured_image"].toString(),
            votesUp: item["votes_up"],
            votesDown: item["votes_down"],
            votersUp: (item["voters_up"] == null) ? <int>[] : jsonDecode(
                item["voters_up"]),
            votersDown: (item["voters_down"] == null) ? <int>[] : jsonDecode(
                item["voters_down"]),
            userId: item["user_id"],
            categoryId: item["category_id"],
        );
        posts.add(post);
      }
    }
    return posts;
  }

  Future<PostDetails> fetChSinglePosts( String id,bool domain1  ) async {
    PostDetails post=new PostDetails(id:"2", title: "title", content: "content", dateWritten: "2021-06-06T15:19:59.000000Z",
        featuredImage: "featuredImage", votesUp: 22, votesDown: 22, votersUp: [], votersDown: [], userId: 2, categoryId: 2,
        created_at: "2021-06-06T15:19:59.000000Z", updated_at: "2021-06-06T15:19:59.000000Z",
        author: new Author(id: "1", name: "name",  avatar: "avatar"), category:new Category("2", "title"));
    //print("******************************************");
    String whatsNewApi;
      if(domain1==true){
      whatsNewApi = base_api1 + post_api + id;
      }else{
      whatsNewApi = base_api + post_api + id;
      }
    // String whatsNewApi = base_api + post_api + id;
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded"
    };

    var url = Uri.parse(whatsNewApi);
    var response = await http.get(url,headers:headers);
    // List<PostDetails> PostDetail = <PostDetails>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];

      for (var item in data) {
        String id1=data[0]["id"].toString();
        String title1=data[0]["title"];
        String content1=data[0]["content"];
        String date_written1=data[0]["date_written"];
        String featured_image1=data[0]["featured_image"];
        int  votes_up=data[0]["votes_up"];//(data[0]["votes_up"] == null) ? 0 : jsonDecode(data[0]["votes_up"]);

        int votes_down=data[0]["votes_down"];//(data[0]["votes_down"] == null) ? 0: jsonDecode(data[0]["votes_down"]);
        List<int> voters_up=(data[0]["voters_up"] == null) ? <int>[] : jsonDecode(data[0]["voters_up"]);
        List<int> voters_down=(data[0]["voters_down"] == null) ? <int>[] : jsonDecode(data[0]["voters_down"]);
        int user_id=data[0]["user_id"];
        int category_id=data[0]["category_id"];
        String created_at=data[0]["created_at"];

        String updated_at=data[0]["updated_at"];
        // List<String> comments=data[0]["comments"];
        Author author=new Author(id: data[0]["author"]["id"].toString(), name: data[0]["author"]["name"],
            avatar:data[0]["author"]["avatar"]);
        Category category=new Category(data[0]["category"]["id"].toString(),data[0]["category"]["title"]);
        post=new PostDetails(id: id1, title: title1, content: content1, dateWritten: date_written1, featuredImage: featured_image1,
            votesUp: votes_up,
            votesDown:votes_down, votersUp: voters_up, votersDown: voters_down, userId: user_id, categoryId: category_id,
            created_at: created_at, updated_at: updated_at, author: author, category: category);
        print(post);
      }
    }
    // print(post);
    return post;
  }

  Future<List<Post>> fetChPostsByCollectionCategoryId(List<int> category,bool domain1) async {
    //print("******************************************");
    String whatsNewApi,postsViewByCategory_api;
    if(domain1==true){
      whatsNewApi = base_api1 + categoriesPostsCollection_api ;
    }else{
      whatsNewApi = base_api + categoriesPostsCollection_api ;
    }
    Map<String,String> headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded"
    };
    Map<String,String> body = {
      "categories" : category.toString(),
    };

    var url = Uri.parse(whatsNewApi);
    // print(url);
    // print(category);

    var response = await http.post(url,headers:headers,body: body
        // body:jsonEncode({ // body of post
        // 'categories' : category,
        // })
    );
    List<Post> posts = <Post>[];
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);

      var data = jsonData["data"];
      // print(data.length());
      for (var item in data) {
        Post post = Post(
          id: item["id"].toString(),
          title: item["title"].toString(),
          content: item["content"].toString(),
          dateWritten: item["date_written"].toString(),
          featuredImage: item["featured_image"].toString(),
          votesUp: item["votes_up"],
          votesDown: item["votes_down"],
          votersUp: (item["voters_up"] == null) ? <int>[] : jsonDecode(
              item["voters_up"]),
          votersDown: (item["voters_down"] == null) ? <int>[] : jsonDecode(
              item["voters_down"]),
          userId: item["author_id"],
          categoryId: item["category_id"],
        );
        print("************************");
        print(post);

        posts.add(post);
      }

    }
    return posts;
  }




}
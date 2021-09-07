import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logout_problem_solution/Screens/single_post.dart';
import 'package:logout_problem_solution/api/authors_api.dart';
import 'package:logout_problem_solution/api/posts_api.dart';
import 'package:logout_problem_solution/models/PostDetails.dart';
import 'package:logout_problem_solution/models/post.dart';
import 'package:logout_problem_solution/utilities/data_utilities.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';

class Favourites extends StatefulWidget {
  late int id;
  late String type;
  late int apiIndex;

  Favourites( this.id,this.type,this.apiIndex);
  @override
  _FavouritesState createState() => _FavouritesState(this.id,this.type,this.apiIndex);
}

class _FavouritesState extends State<Favourites> {
  List<Color> colorsList = [
    Colors.red,
    Colors.teal,
    Colors.deepOrange,
    Colors.indigo,
    Colors.brown,
    Colors.purple
  ];
  Random random = Random();
  Color _getRandomColor() {
    return colorsList[random.nextInt(colorsList.length)];
  }

  PostsAPI postsAPI = PostsAPI();
  AuthorsAPI authorsAPI=new AuthorsAPI();
  late ScrollController _controller;

  late int id;
  late String type;
  late int apiIndex;

  _FavouritesState( this.id,this.type,this.apiIndex);

  @override
  void initState() {
    //Initialize the  scrollController
     _controller = ScrollController();
    super.initState();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }

  @override
  Widget build(BuildContext context) {
  return FutureBuilder(
        future:postsAPI.fetChPostsByCategoryId("$id",true,apiIndex),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          switch ( snapShot.connectionState ){
            case ConnectionState.none :
              return connectionError();
              break;
            case ConnectionState.waiting :
              return loading();
              break;
            case ConnectionState.active :
              return loading();
              break;
            case ConnectionState.done :

              if( snapShot.hasError ){
                return error( snapShot.error );
              }else {
                List<Post> posts = snapShot.data;
                print("++++++++++++++++++++++++++++++++++++++++++++");
                print(posts.length);
                return Scrollbar(
                    isAlwaysShown: true,
                    controller: _controller,

                      child: ListView.builder(
                      controller: _controller,
                      itemBuilder: (context, position) {
                      print(posts[position]);
                      print("==============================================");
                      print(posts[position].userId);
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              FutureBuilder(
                                  future:postsAPI.fetChSinglePosts(posts[position].id,true),
                                  builder: (BuildContext context, AsyncSnapshot snapShot) {
                                    switch ( snapShot.connectionState ){
                                      case ConnectionState.none :
                                        return connectionError();
                                        break;
                                      case ConnectionState.waiting :
                                        return loading();
                                        break;
                                      case ConnectionState.active :
                                        return loading();
                                        break;
                                      case ConnectionState.done :

                                        if( snapShot.hasError ){
                                          return error( snapShot.error );
                                        }else {
                                          if (snapShot.hasData) {
                                            PostDetails post = snapShot.data;
                                            return _authorRow(post,type);
                                          }else {return noData();}
                                          // PostDetails post1 = snapShot.data;
                                          print("*************post1****************");
                                          // print(post1["data"]["id"]);
                                          return _authorRow(snapShot.data,type);
                                        }}}),
                              //         FutureBuilder(
                              // future:authorsAPI.fetChAuthorsByPostId("$id"),
                              // builder: (BuildContext context, AsyncSnapshot<Author> snapshot) {
                              //         return _authorRow("$id");}),
                              //         _authorRow(post1),

                              SizedBox( height: 16, ),
                              _newsItemRow(posts[position]),
                            ],
                          ),
                        ),
                      );
                  },
                  itemCount: posts.length,
                ),
                    );
              }
          }
        }

    );
  }

  Widget _authorRow(PostDetails postDetails,String type) {
    print(postDetails);
    return  Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: // ExactAssetImage('assets/images/placeholder_bg.png'),
                    image:NetworkImage(postDetails.author.avatar),//postDetails.featuredImage
                    // image:ExactAssetImage('assets/images/placeholder_bg.png'),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 16),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.values.first,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                // Text(
                //   // 'Michael Adams',
                //   postDetails.author.name,
                //   style: TextStyle(
                //     color: Colors.grey,
                //   ),
                // ),
                   Row(
                  children: <Widget>[
                  Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 18,
                  ),
                  SizedBox(width:160,child: Text(postDetails.author.name, style: TextStyle(fontSize: 16,color:Colors.blueAccent),)),
                  ]),
                // SizedBox(
                //   height: 8,
                // ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        // '15 Min .',
                        parseHumanDateTime( postDetails.dateWritten ),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      // 'Life Style',
                     // postDetails.category.title,
                      type,
                      style: TextStyle(
                        color: _getRandomColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // IconButton(
        //   icon: Icon(Icons.bookmark_border),
        //   onPressed: () {},
        //   color: Colors.grey,
        // ),
      ],
    );
  }

  Widget _newsItemRow(Post post) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: ( context ){
          return SinglePost( post,true);
        }));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.values.first,

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                  image: NetworkImage( post.featuredImage ),
                  fit: BoxFit.cover),
            ),
            width: 124,
            height: 124,
            margin: EdgeInsets.only( right: 16 ),
          ),
          Expanded(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.values.first,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.values.first,
              children: <Widget>[
                Text(
                  // 'Tech Tent: Old phones and safe social',
                  post.title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8),
                  child: SingleChildScrollView(
                    child: Text(
                      // 'We also talk about the future of work as the robots advance, and we ask whether a retro phone',
                      post.content,
                      maxLines: 4,

                      style: TextStyle(color: Colors.grey, fontSize: 12 , height: 1.25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
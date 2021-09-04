import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logout_problem_solution/CacheHelper.dart';
import 'package:logout_problem_solution/Screens/single_post.dart';
import 'package:logout_problem_solution/api/authors_api.dart';
import 'package:logout_problem_solution/api/categories_api.dart';
import 'package:logout_problem_solution/api/posts_api.dart';
import 'package:logout_problem_solution/models/author.dart';
import 'package:logout_problem_solution/models/category.dart';
import 'package:logout_problem_solution/models/post.dart';
import 'package:logout_problem_solution/utilities/data_utilities.dart';

import '../NavigationDrawer.dart';


class WhatsNew1 extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew1> {
  late PostsAPI postsAPI=new PostsAPI();
  late AuthorsAPI authorsAPI=AuthorsAPI();


  _WhatsNewState();

  late ScrollController _controller;
  late List<int> category;
  late List<String> fav;
  CategoriesAPI categoryapi = new CategoriesAPI();

  @override
  void initState() {
    //Initialize the  scrollController
    _controller = ScrollController();
    print(CacheHelper.getStringList(key: "FollowedCategory"));
    fav=CacheHelper.getStringList(key: "FollowedCategory")??[];

   category = fav==[]?[]:fav.map(int.parse).toList();

    print("category:$category");
    // category=CacheHelper.getStringList(key: "FollowedCategory").toList();

    super.initState();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }


  @override
  // Widget build(BuildContext context) {
  //   postsAPI = PostsAPI();
  //   authorsAPI=AuthorsAPI();
  //   // Future<Author> aut=authorsAPI.fetChAuthorsByPostId("2");
  //   // print("*********************" );
  //   // // print(aut );
  //   // authorsAPI.fetChAuthorsByPostId("2");
  //   // // postsAPI.fetChPostsByCategoryId("2");
  //   // print("*********************" );
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         // _drawHeader(),
  //         // _drawTopStories(),
  //         _drawRecentUpdates(),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // _addCategories();
    print("*******build*********");
    return Stack(
        children: [
          Scaffold(
            body: FutureBuilder(
                future: postsAPI.fetChPostsByCollectionCategoryId(category, false),
                builder: (context, AsyncSnapshot snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      return loading();
                      break;
                    case ConnectionState.active:
                      return loading();
                      break;
                    case ConnectionState.none:
                      return connectionError();
                      break;
                    case ConnectionState.done:
                      if (snapShot.error != null) {
                        return error(snapShot.error);
                      }
                      else {
                        if (snapShot.hasData) {
                          List<Post> Posts = snapShot.data;
                          return Scrollbar(
                            isAlwaysShown: true,
                            controller: _controller,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _controller,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      _drawRecentUpdates(
                                          RandomColor(), Posts[index],
                                          index, Posts.length),
                                    ],
                                  ),
                                );
                              },
                              itemCount: Posts.length,
                            ),
                          );
                        } else {
                          return noData();
                        }
                      };
                      break;
                  }
                }),
          ),
        ]
    );
  }
  Widget _drawHeader() {
    TextStyle _headerTitle = TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600);
    TextStyle _headerDescription = TextStyle(
      color: Colors.white,
      fontSize: 18,
    );
    return Text("jjjjhjhj");

  }
  // Widget _drawTopStories() {
  //   return Container(
  //     color: Colors.grey.shade100,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(left: 16, top: 16),
  //           child: _drawSectionTitle('Top Stories'),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Card(
  //
  //             child: FutureBuilder(
  //               // future: postsAPI.fetchWhatsNew(),
  //               future: postsAPI.fetChPostsByCollectionCategoryId(category, false),
  //               builder: (context, AsyncSnapshot snapShot) {
  //                 switch (snapShot.connectionState) {
  //                   case ConnectionState.waiting:
  //                     return loading();
  //                     break;
  //                   case ConnectionState.active:
  //                     return loading();
  //                     break;
  //                   case ConnectionState.none:
  //                     return connectionError();
  //                     break;
  //                   case ConnectionState.done:
  //                     if (snapShot.error != null) {
  //                       return error(snapShot.error);
  //                     } else {
  //                       if (snapShot.hasData) {
  //                         List<Post> posts = snapShot.data;
  //                         if (posts.length >= 3) {
  //                           Post post1 = snapShot.data[0];
  //                           Post post2 = snapShot.data[1];
  //                           Post post3 = snapShot.data[2];
  //                           return Column(
  //                             children: <Widget>[
  //                               _drawSingleRow(post1),
  //                               _drawDivider(),
  //                               _drawSingleRow(post2),
  //                               _drawDivider(),
  //                               _drawSingleRow(post3),
  //                             ],
  //                           );
  //                         } else {
  //                           return noData();
  //                         }
  //                       } else {
  //                         return noData();
  //                       }
  //                     };                      break;
  //                 }
  //               },
  //             ),
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade100,
    );
  }

  Widget _drawRecentUpdates(Color co, Post post, int index, int len) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _drawRecentUpdatesCard(co, post),
            SizedBox(
              height: 2,
            ),
          ],
        ),

      ),
    );
  }

  Widget _drawSingleRow(Post post) {

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: (){
          Navigator.push( context, MaterialPageRoute(builder: ( context ){
            return SinglePost( post );
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              //   child: Image(
              //     image: ExactAssetImage('assets/images/placeholder_bg.png'),
              //     fit: BoxFit.cover,
              //   ),
              child: Image.network(post.featuredImage, fit: BoxFit.cover,),
              width: 100,
              height: 100,
            ),
            // SizedBox(
            //   width: 16,
            // ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    post.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Container(
                      //     child:FutureBuilder(
                      //         future:authorsAPI.fetChAuthorsByPostId(post.userId.toString(),false),
                      //         builder: (context,AsyncSnapshot  snapShot) {
                      //           switch (snapShot.connectionState) {
                      //             case ConnectionState.waiting:return loading(); break;
                      //             case ConnectionState.active: return loading(); break;
                      //             case ConnectionState.none: return connectionError();break;
                      //             case ConnectionState.done:
                      //               if (snapShot.error != null) {return error(snapShot.error);}
                      //               else {
                      //                 if (snapShot.hasData) {
                      //                   Author author = snapShot.data;
                      //                   return SizedBox(width:500,child: Padding(
                      //                     padding: const EdgeInsets.all(30),
                      //                     child: Text(author.name, style: TextStyle(fontSize: 55,color:Colors.blueAccent),),
                      //                   ));
                      //
                      //                   // return Text(author.name, style: TextStyle(fontSize: 12),);
                      //                 }else {return noData();}
                      //               };break;}})),
                      Row(
                        children: <Widget>[
                          Icon(Icons.timer),
                          // Text('15 min'),
                          Text(parseHumanDateTime(post.dateWritten),
                            style: TextStyle(fontSize: 10),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 16),
    );
  }


  Color RandomColor() {
    Random r = new Random();
    int red = r.nextInt(255);
    int green = r.nextInt(255);
    int blue = r.nextInt(255);
    return new Color.fromRGBO(red, green, blue, 1);
  }
  Widget _drawRecentUpdatesCard(Color color,  Post post) {
    return Card(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: ( context   ){
            return SinglePost(post);
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                  image: NetworkImage( post.featuredImage ),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FutureBuilder(
                  future: categoryapi.fetchCategory(post.categoryId.toString()),
                  builder: (context, AsyncSnapshot snapShot) {
                    switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                    return loading();
                    break;
                    case ConnectionState.active:
                    return loading();
                    break;
                    case ConnectionState.none:
                    return connectionError();
                    break;
                    case ConnectionState.done:
                    if (snapShot.error != null) {
                    return error(snapShot.error);
                    }
                    else {
                    if (snapShot.hasData) {
                    // List<Category> Categories = snapShot.data;
                      Category category=snapShot.data;
                    //  String name="";
                    // for(int i=0;i<Categories.length;++i){
                    //   if(Categories[i].id==post.categoryId){
                    //       name=Categories[i].title;
                    //     }else{name="sport";}
                    //     }
                  return Text(
                    category.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  );}else{return noData();}}
                    }}
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
              child: Text(              post.title,
                // 'Vettel is Ferrari Number One - Hamilton',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
              Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              // Text('Michael Adams',style: TextStyle(fontSize: 12)),
              Container(
              child:FutureBuilder(
              future:authorsAPI.fetChAuthorsByPostId(post.userId.toString(),false),
              builder: (context,AsyncSnapshot  snapShot) {
              switch (snapShot.connectionState) {
              case ConnectionState.waiting:return loading(); break;
              case ConnectionState.active: return loading(); break;
              case ConnectionState.none: return connectionError();break;
              case ConnectionState.done:
              if (snapShot.error != null) {return error(snapShot.error);}
              else {
              if (snapShot.hasData) {
              Author author = snapShot.data;
              return
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: <Widget>[
                    Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(width:160,child: Text(author.name, style: TextStyle(fontSize: 16,color:Colors.blueAccent),)),
                ]),);
              }else {return noData();}
              };break;}})
              //   child: Text("post", style: TextStyle(fontSize: 10),),
              ),
              SizedBox(
              width: 5,
              ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                    size: 18,
                  ),
                  SizedBox(width: 4,),
                  Text(
                    // '15 Min',
                    parseHumanDateTime( post.dateWritten ),
                     style: TextStyle(fontSize: 16,color:Colors.blueAccent)

                  ),
                ],
              ),
            ),]),
          ],
        ),
      ),
    );
  }

}
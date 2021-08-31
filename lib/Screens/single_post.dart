// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:logout_problem_solution/api/Comments_api.dart';
// import 'package:logout_problem_solution/api/authors_api.dart';
// import 'package:logout_problem_solution/models/author.dart';
// import 'package:logout_problem_solution/models/comment.dart';
// import 'package:logout_problem_solution/models/post.dart';
// import 'package:logout_problem_solution/utilities/data_utilities.dart';
//
// class SinglePost extends StatefulWidget {
//   final Post post;
//
//   SinglePost(this.post);
//   @override
//   _SinglePostState createState() => _SinglePostState(this.post);
// }
//
// class _SinglePostState extends State<SinglePost> {
//   final Post post;
//
//   late CommentsAPI commentsAPI;
//   var len;
//   var index=0;
//   late List<Comment>? comments=null;
//   late AuthorsAPI authorsAPI;
//
//   _SinglePostState(this.post);
//
//   @override
//   Widget build(BuildContext context) {
//     commentsAPI=CommentsAPI();
//     commentsAPI.fetChCommentsByPostId(post.id,true);
//     authorsAPI=new AuthorsAPI();
//     this.len= comments!=null?comments!.length:1;
//
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//               expandedHeight: 300.0,
//               floating: true,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: NetworkImage(widget.post.featuredImage),
//                         fit: BoxFit.cover),
//                   ),
//                 ),
//               )),
//           // SliverList(
//           //   delegate: SliverChildBuilderDelegate((context, position) {
//           //     // var e= len==0?len+1:len;
//           //     // len=;
//           //     if (position == 0) {
//           //       return _drawPostDetails();
//           //     } else if(position == 1){
//           //       return FutureBuilder(
//           //           future: commentsAPI.fetChCommentsByPostId(post.id, true),
//           //           builder: (context, AsyncSnapshot snapShot) {
//           //             switch (snapShot.connectionState) {
//           //               case ConnectionState.waiting:
//           //                 return loading();
//           //                 break;
//           //               case ConnectionState.active:
//           //                 return loading();
//           //                 break;
//           //               case ConnectionState.none:
//           //                 return connectionError();
//           //                 break;
//           //               case ConnectionState.done:
//           //                 if (snapShot.error != null) {
//           //                   return error(snapShot.error);
//           //                 }
//           //                 else {
//           //                   if (snapShot.hasData) {
//           //                     List<Comment> Comments = snapShot.data;
//           //                     print(Comments.length);
//           //                     // Comment comment1=Comments[0];//??new Comment(id: "666", content: "ggg", dateWritten: "12-2-2000", userId: "1", postId: "2");
//           //                     return ListView.builder(
//           //                       scrollDirection: Axis.vertical,
//           //                       shrinkWrap: true,
//           //                       // controller: _controller,
//           //                       itemBuilder: (context, index) {
//           //                         return SingleChildScrollView(
//           //                           child: Column(
//           //                             crossAxisAlignment: CrossAxisAlignment.start,
//           //                             children: <Widget>[
//           //                            Column(
//           //                           children: <Widget>[
//           //                           Row(
//           //                           children: <Widget>[
//           //                           CircleAvatar(
//           //                           backgroundImage:
//           //                           ExactAssetImage(
//           //                           "assets/images/placeholder_bg.png"),
//           //                         ),
//           //                         SizedBox(
//           //                         width: 16,
//           //                         ),
//           //                         Column(
//           //                         crossAxisAlignment: CrossAxisAlignment.start,
//           //                         children: <Widget>[
//           //                         Container(
//           //                         child:FutureBuilder(
//           //                         future:authorsAPI.fetChAuthorsByPostId(Comments[index].userId.toString(),true),
//           //                         builder: (context,AsyncSnapshot  snapShot) {
//           //                         switch (snapShot.connectionState) {
//           //                         case ConnectionState.waiting:return loading(); break;
//           //                         case ConnectionState.active: return loading(); break;
//           //                         case ConnectionState.none: return connectionError();break;
//           //                         case ConnectionState.done:
//           //                         if (snapShot.error != null) {return error(snapShot.error);}
//           //                         else {
//           //                         if (snapShot.hasData) {
//           //                         Author author = snapShot.data;
//           //                         return Text(author.name, style: TextStyle(fontSize: 12),);
//           //                         }else {return noData();}
//           //                         };break;}})),
//           //
//           //                         // Text("Christina"),//'Christina'
//           //                         Text(Comments[index]!=null?parseHumanDateTime(Comments[index].dateWritten):"ddd"),
//           //                         ],
//           //                         ),
//           //                         ],
//           //                         ),
//           //                         SizedBox( height: 16,),
//           //                         Text(Comments[index]!=null?Comments[index].content:"ddddd",
//           //                         textAlign: TextAlign.left,
//           //                         )
//           //                         // 'Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable'),
//           //
//           //                         ],
//           //                         ),
//           //                             ],
//           //                           ),
//           //                         );
//           //                       },
//           //                       itemCount: Comments.length,);}else{
//           //                     return noData();
//           //                   }
//           //                 }
//           //             }
//           //           }
//           //       );
//           //     }else{
//           //       _commentTextEntry();
//           //     }
//           //     // else if (position >=1 && position <=this.len) {
//           //     //   print("######################################["+position.toString()+"]:"+len.toString());
//           //     //   Widget c=_comments(position);if(c.runtimeType.toString()!="Card")return _comments(position);
//           //     // } else {
//           //     //   return _commentTextEntry();
//           //     // }
//           //     childCount:3;//len+2
//           //      },
//           //
//           //   )),
//           SliverList(
//             delegate: SliverChildBuilderDelegate((context, position) {
//               // var e= len==0?len+1:len;
//               // len=;
//               if (position == 0) {
//                 return _drawPostDetails();
//               } else if (position >=1 && position <=this.len) {
//                 print("######################################["+position.toString()+"]:"+len.toString());
//                 Widget c=_comments(position);if(c.runtimeType.toString()!="Card")return _comments(position);
//               } else {
//                 return _commentTextEntry();
//               }
//             }, childCount:len+2),
//           ),
//         ]
//           ));
//
//
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   commentsAPI=CommentsAPI();
//   //   commentsAPI.fetChCommentsByPostId("1",true);
//   //   authorsAPI=new AuthorsAPI();
//   //   this.len= comments!=null?comments!.length:1;
//   //
//   //   return Scaffold(
//   //     body: CustomScrollView(
//   //       slivers: <Widget>[
//   //         SliverAppBar(
//   //             expandedHeight: 300.0,
//   //             floating: true,
//   //             pinned: true,
//   //             flexibleSpace: FlexibleSpaceBar(
//   //               background: Container(
//   //                 decoration: BoxDecoration(
//   //                   image: DecorationImage(
//   //                       image: NetworkImage(widget.post.featuredImage),
//   //                       fit: BoxFit.cover),
//   //                 ),
//   //               ),
//   //             )),
//   //         SliverList(
//   //           delegate: SliverChildBuilderDelegate((context, position) {
//   //             // var e= len==0?len+1:len;
//   //             // len=;
//   //             print("position:$position");
//   //             if (position == 0) {
//   //               return _drawPostDetails();
//   //             } else if (position >=1 && position <=this.len) {
//   //               print("######################################["+position.toString()+"]:"+len.toString());
//   //               Widget c=_comments(int.parse(post.id));if(c.runtimeType.toString()!="Card")return _comments(position);
//   //             } else {
//   //               return _commentTextEntry();
//   //             }
//   //           }, childCount:len+2),
//   //         ),
//   //       ],
//   //
//   //     ),
//   //   );
//   //
//   // }
//
//   Widget _drawPostDetails() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Text(
//         widget.post.content,
//         style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.25),
//       ),
//     );
//   }
//
//   Widget _comments(int position) {print("++++++++++++++/"+widget.post.id);
//   return Padding(
//     padding: const EdgeInsets.all(16),
//     child:FutureBuilder(
//         future:commentsAPI.fetChCommentsByPostId(widget.post.id,true),//33 widget.post.id
//         builder:(context,AsyncSnapshot snapShot){
//           switch (snapShot.connectionState) {
//             case ConnectionState.waiting: return loading(); break;
//             case ConnectionState.active:  return loading(); break;
//             case ConnectionState.none:    return connectionError(); break;
//             case ConnectionState.done:
//               if (snapShot.error != null) {  return error(snapShot.error); }
//               else {
//                 if (snapShot.hasData) {
//                   comments = snapShot.data;
//                   this.len=comments!.length;print(len);
//                   // len=comments.length;
//                   //
//                   // if (comments.length >= 1) {
//                   Comment? comment1= comments!=null?comments![position-1]:null;//comments!.length >=position?snapShot.data[position-1]:null;
//                   // ++index;
//                   // Comment comment2= comments.length >=2?snapShot.data[1]:null;
//                   // Comment comment3= comments.length >=3?snapShot.data[2]:null;
//                   // print("commentId:" + comment.id);
//                   if(comment1!=null){
//                     return Column(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           CircleAvatar(
//                             backgroundImage:
//                             ExactAssetImage(
//                                 "assets/images/placeholder_bg.png"),
//                           ),
//                           SizedBox(
//                             width: 16,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                   child:FutureBuilder(
//                                       future:authorsAPI.fetChAuthorsByPostId(comment1.userId.toString(),true),
//                                       builder: (context,AsyncSnapshot  snapShot) {
//                                         switch (snapShot.connectionState) {
//                                           case ConnectionState.waiting:return loading(); break;
//                                           case ConnectionState.active: return loading(); break;
//                                           case ConnectionState.none: return connectionError();break;
//                                           case ConnectionState.done:
//                                             if (snapShot.error != null) {return error(snapShot.error);}
//                                             else {
//                                               if (snapShot.hasData) {
//                                                 Author author = snapShot.data;
//                                                 return Text(author.name, style: TextStyle(fontSize: 12),);
//                                               }else {return noData();}
//                                             };break;}})),
//
//                               // Text("Christina"),//'Christina'
//                               Text(comment1!=null?parseHumanDateTime(comment1.dateWritten):"ddd"),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox( height: 16,),
//                       Text(comment1!=null?comment1.content:"ddddd",
//                         textAlign: TextAlign.left,
//                       )
//                       // 'Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable'),
//
//                     ],
//                   );
//                   }else{return Card();}
//                   // }
//
//                 }else {
//                   return noData();
//                 }
//               };break;
//           }
//
//         }
//     ) ,
//   );
//   }
//
//   Widget _commentTextEntry() {
//     return Container(
//       color: Color.fromRGBO(241, 245, 247, 1),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Flexible(
//                 child: TextField(
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Write Comment here!',
//                       contentPadding: EdgeInsets.only( left: 16 , top: 24 , bottom: 28 )
//                   ),
//                 ),
//               ),
//               FlatButton(
//                 child: Text(
//                   'SEND',
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 8,
//           ),
//         ],
//       ),
//     );
//   }
//   Color getRandomColor({int minBrightness = 50}) {
//     final random = Random();
//     assert(minBrightness >= 0 && minBrightness <= 255);
//     return Color.fromARGB(
//       0xFF,
//       minBrightness + random.nextInt(255 - minBrightness),
//       minBrightness + random.nextInt(255 - minBrightness),
//       minBrightness + random.nextInt(255 - minBrightness),
//     );
//   }
//
// }


import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logout_problem_solution/api/Comments_api.dart';
import 'package:logout_problem_solution/api/authors_api.dart';
import 'package:logout_problem_solution/models/author.dart';
import 'package:logout_problem_solution/models/comment.dart';
import 'package:logout_problem_solution/models/post.dart';
import 'package:logout_problem_solution/utilities/data_utilities.dart';

// class SinglePost extends StatefulWidget {
//   final Post post;
//
//   SinglePost(this.post);
//   @override
//   _SinglePostState createState() => _SinglePostState(this.post);
// }
//
// class _SinglePostState extends State<SinglePost> {
//   late CommentsAPI commentsAPI;
//   var len;
//   var index=0;
//   late List<Comment>? comments=null;
//   late AuthorsAPI authorsAPI;
//   final Post post;
//   _SinglePostState(this.post);
//   @override
//   Widget build(BuildContext context) {
//     commentsAPI=CommentsAPI();
//     commentsAPI.fetChCommentsByPostId(post.id,true);
//     authorsAPI=new AuthorsAPI();
//     this.len= comments!=null?comments!.length:1;
//
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//               expandedHeight: 300.0,
//               floating: true,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: NetworkImage(widget.post.featuredImage),
//                         fit: BoxFit.cover),
//                   ),
//                 ),
//               )),
//           SliverList(2
//             delegate: SliverChildBuilderDelegate((context, position) {
//               // var e= len==0?len+1:len;
//               // len=;
//               if (position == 0) {
//                 return _drawPostDetails();
//               } else if (position >=1 && position <=this.len) {
//                 print("######################################["+position.toString()+"]:"+len.toString());
//                 Widget c=_comments(position);if(c.runtimeType.toString()!="Card")return _comments(position);
//               } else {
//                 return _commentTextEntry();
//               }
//             }, childCount:len+2),
//           ),
//         ],
//
//       ),
//     );
//
//   }
//
//
//   Widget _drawPostDetails() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Text(
//         widget.post.content,
//         style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.25),
//       ),
//     );
//   }
//
//   Widget _comments(int position) {print("************"+widget.post.id);
//   return Padding(
//     padding: const EdgeInsets.all(16),
//     child:FutureBuilder(
//         future:commentsAPI.fetChCommentsByPostId(post.id,true),//33 widget.post.id
//         builder:(context,AsyncSnapshot snapShot){
//           switch (snapShot.connectionState) {
//             case ConnectionState.waiting: return loading(); break;
//             case ConnectionState.active:  return loading(); break;
//             case ConnectionState.none:    return connectionError(); break;
//             case ConnectionState.done:
//               if (snapShot.error != null) {  return error(snapShot.error); }
//               else {
//                 if (snapShot.hasData) {
//                   comments = snapShot.data;
//                   this.len=comments!.length;print(len);
//                   // len=comments.length;
//                   //
//                   // if (comments.length >= 1) {
//                   Comment comment1= comments!.length >=position?snapShot.data[position-1]:null;
//                   ++index;
//                   // Comment comment2= comments.length >=2?snapShot.data[1]:null;
//                   // Comment comment3= comments.length >=3?snapShot.data[2]:null;
//                   // print("commentId:" + comment.id);
//                   if(comment1!=null){                      return Column(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           CircleAvatar(
//                             backgroundImage:
//                             ExactAssetImage(
//                                 "assets/images/placeholder_bg.png"),
//                           ),
//                           SizedBox(
//                             width: 16,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                   child:FutureBuilder(
//                                       future:authorsAPI.fetChAuthorsByPostId(post.id,true),
//                                       builder: (context,AsyncSnapshot  snapShot) {
//                                         switch (snapShot.connectionState) {
//                                           case ConnectionState.waiting:return loading(); break;
//                                           case ConnectionState.active: return loading(); break;
//                                           case ConnectionState.none: return connectionError();break;
//                                           case ConnectionState.done:
//                                             if (snapShot.error != null) {return error(snapShot.error);}
//                                             else {
//                                               if (snapShot.hasData) {
//                                                 Author author = snapShot.data;
//                                                 return Text(author.name, style: TextStyle(fontSize: 12),);
//                                               }else {return noData();}
//                                             };break;}})),
//
//                               // Text("Christina"),//'Christina'
//                               Text(comment1!=null?parseHumanDateTime(post.dateWritten):"ddd"),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox( height: 16,),
//                       Text(comment1!=null?post.content:"ddddd")
//                       // 'Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable'),
//
//                     ],
//                   );
//                   }else{return Card();}
//                   // }
//
//                 }else {
//                   return noData();
//                 }
//               };break;
//           }
//
//         }
//     ) ,
//   );
//   }
//
//   Widget _commentTextEntry() {
//     return Container(
//       color: Color.fromRGBO(241, 245, 247, 1),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Flexible(
//                 child: TextField(
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Write Comment here!',
//                       contentPadding: EdgeInsets.only( left: 16 , top: 24 , bottom: 28 )
//                   ),
//                 ),
//               ),
//               FlatButton(
//                 child: Text(
//                   'SEND',
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 8,
//           ),
//         ],
//       ),
//     );
//   }
//   Color getRandomColor({int minBrightness = 50}) {
//     final random = Random();
//     assert(minBrightness >= 0 && minBrightness <= 255);
//     return Color.fromARGB(
//       0xFF,
//       minBrightness + random.nextInt(255 - minBrightness),
//       minBrightness + random.nextInt(255 - minBrightness),
//       minBrightness + random.nextInt(255 - minBrightness),
//     );
//   }
//
// }


class SinglePost extends StatefulWidget {
  final Post post;

  SinglePost(this.post);
  @override
  _SinglePostState createState() => _SinglePostState(this.post);
}

class _SinglePostState extends State<SinglePost> {
  late CommentsAPI commentsAPI;
  var len;
  var index=0;
  late List<Comment> comments=[];
  late AuthorsAPI authorsAPI;
  final Post post;
  _SinglePostState(this.post);
  @override
  Widget build(BuildContext context) {
    commentsAPI=CommentsAPI();
    commentsAPI.fetChCommentsByPostId("2",true);
    authorsAPI=new AuthorsAPI();
    this.len= comments!=null?comments.length:1;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 300.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.post.featuredImage),
                        fit: BoxFit.cover),
                  ),
                ),
              )),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, position) {
              // var e= len==0?len+1:len;
              // len=;
              if (position == 0) {
                return _drawPostDetails();
              } else if (position >=1 && position <=this.len) {
                print("######################################["+position.toString()+"]:"+len.toString());
                Widget c=_comments(int.parse(post.id));if(c.runtimeType.toString()!="Card")return _comments(position);
              } else {
                return _commentTextEntry();
              }
            }, childCount:len+2),
          ),
        ],
      ),
    );

  }


  Widget _drawPostDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.post.content,
        style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.25),
      ),
    );
  }

  Widget _comments(int position) {print("************"+widget.post.id);
  return Padding(
    padding: const EdgeInsets.all(16),
    child:FutureBuilder(
        future:commentsAPI.fetChCommentsByPostId("2",true),//33 widget.post.id
        builder:(context,AsyncSnapshot snapShot){
          switch (snapShot.connectionState) {
            case ConnectionState.waiting: return loading(); break;
            case ConnectionState.active:  return loading(); break;
            case ConnectionState.none:    return connectionError(); break;
            case ConnectionState.done:
              if (snapShot.error != null) {  return error(snapShot.error); }
              else {
                if (snapShot.hasData) {
                  comments = snapShot.data;
                  // this.len=comments!.length;print(len);
                  // len=comments.length;
                  //
                  // if (comments.length >= 1) {
                  Comment comment1=comments[0]; //comments!.length >=position?snapShot.data[position-1]:null;
                  ++index;

                  // Comment comment2= comments.length >=2?snapShot.data[1]:null;
                  // Comment comment3= comments.length >=3?snapShot.data[2]:null;
                  // print("commentId:" + comment.id);
                  if(comment1!=null){
                    return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                            ExactAssetImage(
                                "assets/images/placeholder_bg.png"),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child:FutureBuilder(
                                      future:authorsAPI.fetChAuthorsByPostId(comment1.userId.toString(),true),
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
                                                return Text(author.name, style: TextStyle(fontSize: 12),);
                                              }else {return noData();}
                                            };break;}})),

                              // Text("Christina"),//'Christina'
                              Text(comment1!=null?parseHumanDateTime(comment1.dateWritten):"ddd"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox( height: 16,),
                      Text(comment1!=null?comment1.content:"ddddd")
                      // 'Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable'),

                    ],
                  );
                  }else{return Card();}
                  // }

                }else {
                  return noData();
                }
              };break;
          }

        }
    ) ,
  );
  }

  Widget _commentTextEntry() {
    return Container(
      color: Color.fromRGBO(241, 245, 247, 1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write Comment here!',
                      contentPadding: EdgeInsets.only( left: 16 , top: 24 , bottom: 28 )
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  'SEND',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
  Color getRandomColor({int minBrightness = 50}) {
    final random = Random();
    assert(minBrightness >= 0 && minBrightness <= 255);
    return Color.fromARGB(
      0xFF,
      minBrightness + random.nextInt(255 - minBrightness),
      minBrightness + random.nextInt(255 - minBrightness),
      minBrightness + random.nextInt(255 - minBrightness),
    );
  }

}
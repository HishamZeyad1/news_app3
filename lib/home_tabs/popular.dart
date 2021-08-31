import 'package:flutter/material.dart';
import 'package:logout_problem_solution/Screens/single_post.dart';
import 'package:logout_problem_solution/api/authors_api.dart';
import 'package:logout_problem_solution/api/posts_api.dart';
import 'package:logout_problem_solution/models/author.dart';
import 'package:logout_problem_solution/models/post.dart';
import 'package:logout_problem_solution/utilities/data_utilities.dart';

class Popular extends StatefulWidget {
  late int id;
  Popular( this.id);

  @override
  _PopularState createState() => _PopularState(this.id);
}

class _PopularState extends State<Popular> {
  PostsAPI postsAPI = PostsAPI();

  AuthorsAPI authorsAPI=new AuthorsAPI();
  late int id;
  _PopularState(int id){this.id=id;}
  late ScrollController _controller;

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
        future: postsAPI.fetChPostsByCategoryId("$id",true,2),
        builder: (context, AsyncSnapshot snapShot) {
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
                print(posts);
                 return Scrollbar(
                    isAlwaysShown: true,
                    controller: _controller,

                   child: ListView.builder(
                     controller: _controller,
                    itemBuilder: (context, position) {
                    return Card(
                      // child: _drawSingleRow(),
                      child: _drawSingleRow( posts[position] ) ,
                    );
                  }, itemCount: posts.length,
                ));
              }
          }

        });
  }



  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: ( context ){
            return SinglePost( post );
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.values.first,
          children: <Widget>[
            SizedBox(
              child: Image(
                // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                image: NetworkImage( post.featuredImage ),
                fit: BoxFit.cover,
              ),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    // 'The World ',//
                    post.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text('Michael Adams',style: TextStyle(fontSize: 12)),
                      Container(
                          child:FutureBuilder(
                              future:authorsAPI.fetChAuthorsByPostId(post.userId.toString(),true),
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
                                        return SizedBox(width:160,child: Text(author.name, style: TextStyle(fontSize: 16,color:Colors.blueAccent),));
                                      }else {return noData();}
                                    };break;}})
                          //   child: Text("post", style: TextStyle(fontSize: 10),),
            ),
                      SizedBox(
                        width: 15,
                      ),

                      Row(
                        children: <Widget>[
                          Icon(Icons.timer),
                          // Text('15 min'),

                          Text( parseHumanDateTime( post.dateWritten ),
                              style: TextStyle(fontSize: 16,color:Colors.blueAccent)),


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
}
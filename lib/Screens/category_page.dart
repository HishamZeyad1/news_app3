// import 'dart:js';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:logout_problem_solution/CacheHelper.dart';
import 'package:logout_problem_solution/HomeScreen.dart';
import 'package:logout_problem_solution/NavigationDrawer.dart';
import 'package:logout_problem_solution/api/categories_api.dart';
import 'package:logout_problem_solution/models/category.dart';
import 'package:logout_problem_solution/utilities/data_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';


class CategoryPage extends StatefulWidget {
  @override
  CategoryPageState createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  // late PostsAPI postsAPI;
  late Future<List<Category>> Categories;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);
  late List<bool> _checked = [];
  late List<int> _ids = [];

  late List<SharedPreferences> prefs = [];
  List<String> FollowedCategory=[];

  // late Map<String,bool> map={"key":follow,"value":true};
  bool block = false;
  late final int? length;

  CategoriesAPI categoryapi = new CategoriesAPI();
  bool onchange=false;
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
    // _addCategories();
    print("*******build*********");
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose  Categories"),
        centerTitle: false,
      ),
      drawer: NavigationDrawer(),
      body: Stack(
          children: [
            Scaffold(
              body: FutureBuilder(
                  future: categoryapi.fetchCategories(),
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
                            List<Category> Categories = snapShot.data;
                            if(!onchange){
                            for (int i = 0; i < Categories.length; ++i) {
                              int id = int.parse(Categories[i].id.toString());
                              _checked.add(false);
                              _checked[i] =
                              (CacheHelper.getbool(key: "$id") == null
                                  ? _checked[i]
                                  : CacheHelper.getbool(key: "$id"))!;
                              _ids.add(id);
                              // _categoriescheck.add(new categoryCheck(id, _checked[i]));
                            }onchange=true;
                            }
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
                                            RandomColor(), Categories[index],
                                            index, Categories.length),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: Categories.length,
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
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 24),
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .height * 0.6,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.red.shade900,
                      child: Text(
                        'Follow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                      onPressed: () {

                        print("************************************");

                        print(_checked);
                        if (_checked.contains(true)) {
                          // _updateFollow();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "you must select at least one category",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        _updateFollow();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }

  Color RandomColor() {
    Random r = new Random();
    int red = r.nextInt(255);
    int green = r.nextInt(255);
    int blue = r.nextInt(255);
    return new Color.fromRGBO(red, green, blue, 1);
  }

  Widget _drawRecentUpdates(Color co, Category ca, int index, int len) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _drawRecentUpdatesCard(co, ca, index, len),
            SizedBox(
              height: 2,
            ),
          ],
        ),

      ),
    );
  }

  Widget _drawRecentUpdatesCard(Color color, Category post, int index,
      int length) {
    return Stack(
        children: <Widget>[
          Card(
            child: GestureDetector(
              onTap: () {
                // setState(() {
                //   _checked[index]=!_checked[index];
                //   print(_checked[index]);
                //
                //   print("NewsFavoriteList$NewsFavoriteList");
                // });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                        image: NetworkImage(post.image),
                        // image: ExactAssetImage(post.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5 /*, left: 16*/),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(/*left: 24, */
                          right: 24, top: 2, bottom: 0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        post.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 0),
                    // padding: EdgeInsets.all(0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height:  MediaQuery .of(context) .size .height * 0.4,
            child: CheckboxListTile(
              // secondary: Icon(Icons.check,size: 200,),
              value: _checked[index],
              activeColor: Colors.blue,
              checkColor: Colors.white,
              // tileColor:Colors.green,
              onChanged: (bool? value) {
                setState(() {
                  _checked[index] = !_checked[index];
                  // _checked=!_checked;
                  print(_checked[index]);
                  // print("NewsFavoriteList$NewsFavoriteList");
                });
              },
            ),
          ),
          // FlutterWebScroller(
          //   //Pass a reference to the ScrollCallBack function into the scrollbar
          //   scrollCallBack,
          //
          //   //Add optional values
          //   scrollBarBackgroundColor: Colors.white,
          //   scrollBarWidth: 20.0,
          //   dragHandleColor: Colors.red,
          //   dragHandleBorderRadius: 2.0,
          //   dragHandleHeight: 40.0,
          //   dragHandleWidth: 15.0,
          // ),
        ]
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

  void _updateFollow() {
    for (int index = 0; index < _checked.length; ++index) {
      print("**************************************************************");
      int id=_ids[index];
      CacheHelper.putbool(key: "${id}", value: _checked[index]);
      if(_checked[index]==true){
        FollowedCategory.add(_ids[index].toString());
      }
    }
    CacheHelper.StringList(key: "FollowedCategory", value: FollowedCategory);
    print(CacheHelper.getStringList(key: "FollowedCategory"));
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logout_problem_solution/Screens/home_screen.dart';
import 'package:logout_problem_solution/home_tabs/favourites.dart';
import 'package:logout_problem_solution/home_tabs/popular.dart';
import 'package:logout_problem_solution/home_tabs/whats_new.dart';
import 'package:logout_problem_solution/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationDrawer.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';


class CategoryView extends StatefulWidget {
  // final Category category;

  // CategoryPage(this.category);
  @override
  CategoryPageState createState() {
    return new CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryView>with SingleTickerProviderStateMixin{
  // late PostsAPI postsAPI;
  // late CategoryAPI postsAPI;

  late List<Category> Categories;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);
  late ScrollController _controller;
  // late TabController _tabController;

  void _addCategories() {
    Categories = <Category>[];

    Categories.add(Category("1","Policy", 'assets/images/news/political-news.jpg'));
    Categories.add(Category("2","Economy", 'assets/images/news/Economy1.jpg'));
    Categories.add(Category("3","Sport", 'assets/images/news/sportCategory2.jpg'));
    Categories.add(Category("4","Healthy", 'assets/images/news/health news1.png'));
    Categories.add(Category("5","Science", 'assets/images/news/Science News5.jpeg'));
    Categories.add(Category("6","Technology", 'assets/images/news/technogy news4.jpeg'));
    Categories.add(Category("7","Tourism", 'assets/images/news/Tourism news1.jpg'));
  }

  void initState() {
    //Initialize the  scrollController
    _controller = ScrollController();
    // _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _tabController.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    _addCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: false,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
        //   // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        //   // _popOutMenu(context),
        //
        // ],
      ),
      drawer: NavigationDrawer(),
      body:Stack(
          children:[
            Scaffold(
              body:Scrollbar(
              isAlwaysShown: true,
              controller: _controller,

              child:ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: _controller,
                        itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _drawRecentUpdates(RandomColor(),Categories[index],index),
                                ],
                              ),
                            );
                          },
                          itemCount: Categories.length,

                          // onPageChanged: (index) {
                          //   _pageViewNotifier.value = index;
                          // },
                        ),
                        ),)

          ]

      ),
    );

  }
  Color RandomColor(){
    Random r=new Random();
    int red=r.nextInt(255);
    int green=r.nextInt(255);
    int blue=r.nextInt(255);
    return new Color.fromRGBO(red, green, blue, 1);
  }
  Widget _drawRecentUpdates(Color co,Category ca,int index) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _drawRecentUpdatesCard( co,ca,index),

            SizedBox(
              height: 5,
            ),
          ],
        ),

      ),
    );
  }
  Widget _drawRecentUpdatesCard(Color color,  Category category,int index) {
    String type;
    switch(index){
      case 0:type="Political News";break;
      case 1:type="Economy News";break;
      case 2:type="Sport News";break;
      case 3:type="Healthy News";break;
      case 4:type="Sciences News";break;
      case 5:type="Technology News";break;
      case 6:type="Tourism News";break;
      default:type="... News";break;
    }

          return SingleChildScrollView(
            child:        Card(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: ( context   ){
                    // return Scaffold(
                    //   appBar: AppBar(
                    //     title: Text("$type"),
                    //     centerTitle: false,
                    //     bottom: TabBar(
                    //       indicatorColor: Colors.white,
                    //       tabs: [
                    //         Tab(
                    //           text: "WHAT'S NEW",
                    //         ),
                    //         Tab(
                    //           text: "POPULAR",
                    //         ),
                    //         Tab(
                    //           text: "FAVOURITES",
                    //         ),
                    //       ],
                    //       controller: _tabController,
                    //     ),
                    //   ),
                    //   drawer: NavigationDrawer(),
                    // body: Center(
                    // child:TabBarView( children: [
                    //   WhatsNew(id),
                    //   Popular(id),
                    //   Favourites(id)
                    // ] , controller: _tabController,  ),
                    // ),
                    // );
                    int id=index+1;
                    return HomeScreen(type, id);
                    // return Container();
                  }));
                },
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                          // image: NetworkImage( post.featuredImage ),
                          image: ExactAssetImage(category.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: double.infinity,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5/*, left: 16*/),
                      child: Container(
                        width:double.infinity,
                        padding: EdgeInsets.only(/*left: 24, */right: 24, top: 2, bottom: 0),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          category.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                      // padding: EdgeInsets.all(0),
                    ),
                  ],
                ),
              ),
            ),);
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
}
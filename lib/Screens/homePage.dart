import 'package:flutter/material.dart';
import 'package:logout_problem_solution/api/authors_api.dart';
import 'package:logout_problem_solution/api/categories_api.dart';
import 'package:logout_problem_solution/api/posts_api.dart';
import 'package:logout_problem_solution/home_tabs/whats_new1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationDrawer.dart';
import '../home_tabs/favourites.dart';
import '../home_tabs/popular.dart';
import '../home_tabs/whats_new.dart';
import '../shared_ui/navigation_drawer.dart';

class HomeScreen1 extends StatefulWidget {
  List<int> NewsFavoriteList=[];
  List<SharedPreferences> prefs=[];
  HomeScreen1();

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AuthorsAPI authorsAPI = AuthorsAPI();
  CategoriesAPI categoriesAPI=CategoriesAPI();
  PostsAPI postsAPI=PostsAPI();

  _HomeScreen1State();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
          title: Text("News App"),
          centerTitle: true,
          // actions: <Widget>[
          //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
          //   // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          //   _popOutMenu(context),
          // ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "LatestNews",//"WHAT'S NEW",
              ),
              // Tab(
              //   text: "OldestNews",//"POPULAR",
              // ),
              // Tab(
              //   text: "VotesUp",
              // ),
              // Tab(
              //   text: "VotesDown",
              // ),
            ],
            controller: _tabController,
          ),
        ),
      // drawer: NavigationDrawer(),
      body: Center(
        child:TabBarView( children: [
          WhatsNew1(),
          // Popular(id),
          // Favourites(id,type,3),
          // Favourites(id,type,4)
        ] , controller: _tabController,  ),
      ),
    );


  }
}
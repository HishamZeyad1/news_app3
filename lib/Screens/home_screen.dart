import 'package:flutter/material.dart';
import 'package:logout_problem_solution/api/authors_api.dart';
import 'package:logout_problem_solution/api/categories_api.dart';
import 'package:logout_problem_solution/api/posts_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationDrawer.dart';
import '../home_tabs/favourites.dart';
import '../home_tabs/popular.dart';
import '../home_tabs/whats_new.dart';
import '../shared_ui/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  List<int> NewsFavoriteList=[];
  List<SharedPreferences> prefs=[];
  String type;int id;
  HomeScreen(this.type,this.id);
    //{List<int> NewsFavoriteList}
    // this.NewsFavoriteList=NewsFavoriteList;
    // if(NewsFavoriteList!=null){_updateFollow();}

  @override
  _HomeScreenState createState() => _HomeScreenState(this.type,this.id);
// void sharedata() async {
//   prefs=[];
//   prefs.length=7;
//   for(int index=0;index<prefs.length;++index){
//     prefs[index]=await  SharedPreferences.getInstance();
//   }
// }
// void _updateFollow() {
//   sharedata();
//   for(int index=0;index<NewsFavoriteList!.length;++index){
//     print("**************************************************************");
//     prefs[NewsFavoriteList![index]].setBool('follow' ,true);
//   }
//   // print(prefs);
// }

}
enum PopOutMenu { HELP, ABOUT, CONTACT, SETTINGS }

class _HomeScreenState extends State<HomeScreen>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AuthorsAPI authorsAPI = AuthorsAPI();
  CategoriesAPI categoriesAPI=CategoriesAPI();
  PostsAPI postsAPI=PostsAPI();

  String type;int id;
  _HomeScreenState(this.type,this.id);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }



  @override
  Widget build(BuildContext context) {

    //authorsAPI.fetchAllAuthors();
    // categoriesAPI.fetchCategories();
    //postsAPI.fetchWhatsNew();
    return Scaffold(
      appBar: AppBar(
        title: Text("$type"),
        centerTitle: false,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
        //   // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        //   _popOutMenu(context),
        // ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "WHAT'S NEW",
            ),
            Tab(
              text: "POPULAR",
            ),
            Tab(
              text: "FAVOURITES",
            ),
        Tab(
           text: "VotesUp",
            ),
          ],
          controller: _tabController,
        ),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child:TabBarView( children: [
          WhatsNew(id,type),
          Popular(id),
          Favourites(id,type,3),
          Favourites(id,type,4)
        ] , controller: _tabController,  ),
      ),
    );


  }
  // Widget _popOutMenu(BuildContext context) {
  //   return PopupMenuButton<PopOutMenu>(
  //     itemBuilder: (context) {
  //       return [
  //         PopupMenuItem<PopOutMenu>(
  //           value: PopOutMenu.ABOUT,
  //           child: Text('ABOUT'),
  //
  //         ),
  //         PopupMenuItem<PopOutMenu>(
  //           value: PopOutMenu.CONTACT,
  //           child: Text('CONTACT'),
  //         ),
  //         PopupMenuItem<PopOutMenu>(
  //           value: PopOutMenu.HELP,
  //           child: Text('HELP'),
  //         ),
  //         PopupMenuItem<PopOutMenu>(
  //           value: PopOutMenu.SETTINGS,
  //           child: Text('SETTINGS'),
  //         ),
  //       ];
  //     },
  //     onSelected: (PopOutMenu menu) {
  //       // TODO :
  //       switch( menu ){
  //         case PopOutMenu.ABOUT :
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return AboutUs();
  //           }));
  //           break;
  //         case PopOutMenu.SETTINGS:
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return Settings();
  //           }));
  //           break;
  //         case PopOutMenu.CONTACT :
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return ContactUs();
  //           }));
  //           break;
  //         case PopOutMenu.HELP :
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return Help();
  //           }));
  //           break;
  //       }
  //     },
  //     icon: Icon(Icons.more_vert),
  //   );
  // }
}
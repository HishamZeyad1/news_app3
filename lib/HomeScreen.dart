import 'package:flutter/material.dart';
import 'package:logout_problem_solution/Screens/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NavigationDrawer.dart';
import 'NavigationDrawerWidget.dart';
class HomeScreen extends StatefulWidget {
  List<int> NewsFavoriteList=[];
  List<SharedPreferences> prefs=[];
  HomeScreen(){//{List<int> NewsFavoriteList}
    // this.NewsFavoriteList=NewsFavoriteList;
    // if(NewsFavoriteList!=null){_updateFollow();}
  }
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text("News App")),
      //   centerTitle: false,
      // ),
      drawer: NavigationDrawer(),
      body:HomeScreen1(),
    );


  }

}
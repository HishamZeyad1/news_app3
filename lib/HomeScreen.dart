import 'package:flutter/material.dart';
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
//     print("**********************");
//     prefs[NewsFavoriteList![index]].setBool('follow' ,true);
//   }
//   // print(prefs);
// }

}

class _HomeScreenState extends State<HomeScreen>with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        centerTitle: false,
      ),
      drawer: NavigationDrawer(),
    );


  }

}
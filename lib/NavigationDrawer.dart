import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logout_problem_solution/CacheHelper.dart';
import 'package:logout_problem_solution/HomeScreen.dart';
import 'package:logout_problem_solution/Screens/category_page.dart';
import 'package:logout_problem_solution/nav_menu.dart';
import 'package:logout_problem_solution/page/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'register.dart';
// import 'package:logout_problem_solution/register.dart';

import 'logout.dart';
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();

}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late bool? token=CacheHelper.getbool(key: "token")??null;
  late bool isLoggedIn = (token==null||token==false)?false:true;

  // late  String strlogin=(token==true)?"Logout":"Login";
  // late SharedPreferences? sharedPreferences=null;
  int _a=3;
  int get a{return _a;}
  late List<bool> _checked=[];
  final padding = EdgeInsets.symmetric(horizontal: 20);

  late List<NavMenuItem> navigationMenu;
  NavigationDrawer(){
     navigationMenu = [

      NavMenuItem(isLoggedIn?"Logout":"Login",isLoggedIn?Icons.logout:Icons.login,isLoggedIn?() => Logout():() =>Login()),
       NavMenuItem("register",Icons.app_registration,()=>Register()),
       NavMenuItem("select Category",Icons.category ,() => CategoryPage() ),

       // ListTile(
      // leading: Icon(Icons.people),
      // title: Text("people"),
      // // hoverColor: hoverColor,
      // // onTap: onClicked,
      // ),

     ];
  }

  @override
  Widget build(BuildContext context) {

    // navigationMenu.add(strlogin.toString(),() =>Login());
    // sharedata();
    NavigationDrawer();
    if( this.mounted ){
      _checkToken();
    }
    bool? profileSwitch=CacheHelper.getbool(key: "token")??false;
    final name=profileSwitch?CacheHelper.getstring(key: "name")??"Hisham Zeyad":"Sarah Abs",
          email=profileSwitch?CacheHelper.getstring(key: "email")??"":"sarah@abs.com",
          urlImage=profileSwitch?CacheHelper.getstring(key: "avatar")??"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80":
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";

    // if(profileSwitch==true){
    //    name = 'Sarah Abs';
    //    email = 'sarah@abs.com';
    //    urlImage =
    //       'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    // }

    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 2),
          child: Column(
            children:[
              buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserPage(
                    name: name,
                    urlImage: urlImage,
                  ),
                )),
              ),
            ListView.builder(
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        // tileColor: Colors.blue,
                        leading: Icon(navigationMenu[position].icon, color: Colors.white),
                        title: Text(
                          navigationMenu[position].title,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => navigationMenu[position].destination() ));
                        },
                      ),
                    );
                  },
                  itemCount: navigationMenu.length,
                ),


            ],

          ),

        ),
      ),
    );
  }
  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 10)),
          child: Row(
            children: [
              CircleAvatar(radius: 30,
              backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 15,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  _checkToken() async{
    // sharedPreferences = await SharedPreferences.getInstance();
    // token = sharedPreferences!.getBool('token')!;
    setState(() {

    });
  }


}
import 'package:flutter/material.dart';
import 'package:logout_problem_solution/CacheHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';
// import 'package:news_app2/api/authentication_api.dart';
// import 'package:news_app2/helper/CacheHelper.dart';
// import 'package:news_app2/screens/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  // SharedPreferences? sharedPreferences=null;
  // int a;
  static String? token;

  @override
  _LogoutState createState() => _LogoutState();

// Logout(int a){
//   this.a= a;
// }
}
class _LogoutState extends State<Logout> {
  static bool isLoggedIn = CacheHelper.getbool(key: "isLoggedIn")??false;
  static bool? token=      CacheHelper.getbool(key: "token")??null;

// void c(){
//  // token=CacheHelper.getbool(key: "token")??null;
//  //  Logout.token=sharedPreferences.getString("token")??null;
//
// }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   //  sharedPreferences=CacheHelper.init();
  //   //  token=CacheHelper.getbool(key: 'token');
  //   print(checktokenValue());
  //   print("**Hisham**");
  // }

  // Future<bool?> checktokenValue() async {
  //  // sharedPreferences=CacheHelper.init();
  //   token=CacheHelper.getbool(key: 'token');
  //   return token;
  // }

  @override
  Widget build(BuildContext context) {

    // c();
    // bool? tokentint=CacheHelper.getbool(key: "token");
    // print(token != null);
    // print(isLoggedIn);
    print(Logout.token);

    print("**hhhhh**");
    // //
    if( token != null ){
      CacheHelper.sharedPreferences1!.remove('token');
      // CacheHelper.putbool(key: "token", value: false);
      CacheHelper.putstring(key: "name", value: null);
      CacheHelper.putstring(key: "email", value: null);
      CacheHelper.putstring(key: "avatar", value: null);
    }
    // SharedPreferences sharedPreferences=CacheHelper.init();
    //  sharedPreferences.setBool("isLoggedIn",false);
    // print(sharedPreferences.getBool("isLoggedIn"));
    //
    setState(() {
    });
    return HomeScreen();
  }

// _checkToken() async{
//   initState();
//   setState(() {
//     if( token == null ){
//       isLoggedIn = false;
//     }else{
//       isLoggedIn = true;
//     }
//   });
// }

// @override
// Future<void> initState() async {
//   super.initState();
//   sharedPreferences = await SharedPreferences.getInstance();
//   token = sharedPreferences.getBool('token')!;
// }


}
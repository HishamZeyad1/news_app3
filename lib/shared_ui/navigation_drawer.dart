// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../HomeScreen.dart';
// import '../nav_menu.dart';
//
// class NavigationDrawer extends StatefulWidget {
//   @override
//   _NavigationDrawerState createState() => _NavigationDrawerState();
//
// }
//
// class _NavigationDrawerState extends State<NavigationDrawer> {
//   static bool isLoggedIn = false;
//   late bool token;
//   late SharedPreferences? sharedPreferences=null;
//   int _a=3;
//   int get a{return _a;}
//   late List<bool> _checked=[];
//   late List<SharedPreferences> prefs=[];
//   void sharedata() async {
//     prefs=[];
//     prefs.length=_checked.length;
//     // bool? _checked[0] = prefs[0].getBool('follow')!;
//     for(int index=0;index<prefs.length;++index){
//       print("**************************************************************");
//       prefs[index]=await  SharedPreferences.getInstance();
//       _checked[index] = prefs[index].getBool('follow')!;
//     }
//     // prefs=[await  SharedPreferences.getInstance(),
//     // await  SharedPreferences.getInstance(), await  SharedPreferences.getInstance(),
//     // await  SharedPreferences.getInstance(), await  SharedPreferences.getInstance(),
//     // await  SharedPreferences.getInstance(), await  SharedPreferences.getInstance()];
//     // _checked[0] = prefs[0].getBool('follow')!;_checked[1] = prefs[1].getBool('follow')!;
//     // _checked[2] = prefs[2].getBool('follow')!;_checked[3] = prefs[3].getBool('follow')!;
//     // _checked[4] = prefs[4].getBool('follow')!;_checked[5] = prefs[5].getBool('follow')!;
//     // _checked[6] = prefs[6].getBool('follow')!;
//     print("############################sharedata##############################");
//     print("prefs[0]:");print(prefs[0].getBool('follow')!);
//     // for(int a=0;a<prefs.length;++a){
//     //   // prefs.add(await  SharedPreferences.getInstance());
//     //     _checked[a] = prefs[a].getBool('follow')!;
//     //   }
//   }
//
//   // SharedPreferences? get sharedPreferences =>
//   //     _sharedPreferences; // late final Logout logout=new Logout(sharedPreferences1);
//
//   List<NavMenuItem> navigationMenu = [
//     NavMenuItem('Explore',()=>HomeScreen()),
//     NavMenuItem('Headline News',()=>HeadLineNews()),
//     NavMenuItem('TwitterFeeds',()=>TwitterFeed()),
//     NavMenuItem("Instagram Feeds", () => InstagramFeed() ),
//     NavMenuItem("Facebook Feeds", () => FacebookFeeds() ),
//     NavMenuItem("select Category", () => CategoryPage() ),
//     NavMenuItem("view Category", () => CategoryView() ),
//
//     NavMenuItem(isLoggedIn?"LogIn":"Logout",isLoggedIn?() => Login():() =>Login()),
// //    NavMenuItem("Register", () => FacebookFeeds() ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     // sharedata();
//     if( this.mounted ){
//       _checkToken();
//     }
//     return Drawer(
//       child: Padding(
//         padding: EdgeInsets.only(top: 75, left: 24),
//         child: ListView.builder(
//           itemBuilder: (context, position) {
//             return Padding(
//               padding: const EdgeInsets.all(8),
//               child: ListTile(
//                 title: Text(
//                   navigationMenu[position].title,
//                   style: TextStyle(color: Colors.grey.shade700, fontSize: 22),
//                 ),
//                 trailing: Icon(
//                   Icons.chevron_right,
//                   color: Colors.grey.shade400,
//                 ),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => navigationMenu[position].destination() ));
//                 },
//               ),
//             );
//           },
//           itemCount: navigationMenu.length,
//         ),
//       ),
//     );
//   }
//
//   _checkToken() async{
//     sharedPreferences = await SharedPreferences.getInstance();
//     token = sharedPreferences!.getBool('token')!;
//     setState(() {
//       if( token == null ){
//         isLoggedIn = false;
//       }else{
//         isLoggedIn = true;
//       }
//     });
//   }
//
//   // _logout(){
//   //   if( sharedPreferences != null ){
//   //     sharedPreferences!.remove('token');
//   //   }
//   //   return HomeScreen();
//   // }
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   if( isLoggedIn ){
//   //     navigationMenu.add( NavMenuItem("Logout", _logout() ) );
//   //   }
//   // }
//
// }
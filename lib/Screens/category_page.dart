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

  late List<int> NewsFavoriteList = [];
  late List<SharedPreferences> prefs = [];

  // late Map<String,bool> map={"key":follow,"value":true};
  bool block = false;
  late final int? length;

  CategoriesAPI categoryapi = new CategoriesAPI();
  bool onchange=false;
  // void _addCategories() {
  //   Categories = categoryapi.fetchCategories();
  //   // Categories.add(Category("1","Policy", 'assets/images/news/political-news.jpg'));
  //   // Categories.add(Category("2","Economy", 'assets/images/news/Economy1.jpg'));
  //   // Categories.add(Category("3","Sport", 'assets/images/news/sportCategory2.jpg'));
  //   // Categories.add(Category("4","Healthy", 'assets/images/news/health news1.png'));
  //   // Categories.add(Category("5","Science", 'assets/images/news/Science News5.jpeg'));
  //   // Categories.add(Category("6","Technology", 'assets/images/news/technogy news4.jpeg'));
  //   // Categories.add(Category("7","Tourism", 'assets/images/news/Tourism news1.jpg'));
  // }
  // void ss() async {
  //   print("********ss()**********");
  //
  //   Categories = categoryapi.fetchCategories();    print("******************");
  //   print(await categoryapi.getLength());
  //
  //   length=categoryapi.getLength() as int?;    print("******************");
  //   _checked.length=length??0;     print("******************");
  //
  //   print("******************");
  //   print(_checked.length);
  //   for(int i=0;i<_checked.length;++i){
  //     _checked.add(false);
  //     _checked[i] =(CacheHelper.getbool(key:"check$i")==null?false:CacheHelper.getbool(key:"check$i"))!;
  //   }
  //   print("********End ss()**********");
  //
  // }
  // @override
  // void initState() {
  //   print("*******initState*********");
  //   super.initState();
  //   WidgetsFlutterBinding.ensureInitialized();
  //   // ss();
  //   // Categories = categoryapi.fetchCategories();
  //   // final int? length=await categoryapi.getLength()??0;
  //   // // int all=(Categories as List).length;
  //   // for(int i=0;i<length!;++i){
  //   //   _checked.add(false);
  //   //   _checked[i] =(CacheHelper.getbool(key:"check$i")==null?_checked[i]:CacheHelper.getbool(key:"check$i"))!;
  //   // }
  //   // TODO: implement initState
  //
  //   // Future<int?> len=categoryapi.getLength();int z=len as int;
  //   // if(z==0){ }else{
  //   //   for(int i=0;i<z;++i){
  //   //     _checked.add(false);
  //   //     _checked[i] =(CacheHelper.getbool(key:"check$i")==null?_checked[i]:CacheHelper.getbool(key:"check$i"))!;
  //   //   }
  //   // }
  // }
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
                              _checked.add(false);
                              _checked[i] =
                              (CacheHelper.getbool(key: "check$i") == null
                                  ? _checked[i]
                                  : CacheHelper.getbool(key: "check$i"))!;
                            }onchange=true;
                            }
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
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
    // for(int i=0;i<length;++i){
    //   _checked.add(false);
    //   _checked[i] =(CacheHelper.getbool(key:"check$i")==null?_checked[i]:CacheHelper.getbool(key:"check$i"))!;
    // }
    //
    // print( "Hisham Zeyad:");
    // print(prefs);
    // print(prefs.length);//prefs.isEmpty?_checked[index]:prefs[index].getBool('follow')
    // print(_checked[index]);
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
    //
    // //   SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("###############################################################");
    //
    for (int index = 0; index < _checked.length; ++index) {
      print("**************************************************************");
      CacheHelper.putbool(key: "check${index}", value: _checked[index]);
    }
  }
}
// class CheckBox extends StatefulWidget {
//   bool _checked=false;
//   int index=0,length=0;
//   _CheckBoxState createState() => _CheckBoxState(_checked,index,length);
//   CheckBox(bool _checked1,int index1,int length1){_checked=_checked1;index=index1;length=length1;}
// }
//
// class _CheckBoxState extends State {
//   late double val;
//   bool _checked=false;
//   int index=0,length=0;
//   void initState() {
//     print("initState");
//     super.initState();
//     val = 0;
//     // for (int i = 0; i <length; ++i) {
//     //   _checked.add(false);
//     //   _checked[i] =
//     //   (CacheHelper.getbool(key: "check$i") == null ? _checked[i] : CacheHelper
//     //       .getbool(key: "check$i"))!;
//     // }
//   }
//
//   _CheckBoxState(bool _checked1,int index1,int length1) {
//     _checked = _checked1;index=index1;length=length1;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return _drawCheckbox(_checked);
//   }
//
//   Widget _drawCheckbox(bool b) {
//     bool block = false;
//
//     return CheckboxListTile(
//       // secondary: Icon(Icons.check,size: 200,),
//       value: b,
//       activeColor: Colors.blue,
//       checkColor: Colors.white,
//       // tileColor:Colors.green,
//       onChanged: (bool? value) {
//         setState(() {
//           b = !b;
//           // _checked=!_checked;
//           print(b);
//           // print("NewsFavoriteList$NewsFavoriteList");
//         });
//       },
//     );
//   }
//
//   void _updateFollow() {
//     for (int index = 0; index < length; ++index) {
//       print("**************************************************************");
//       CacheHelper.putbool(key: "check${index}", value: _checked);
//     }
//   }
// // class CheckPage extends StatefulWidget {
// //   List<bool> _checked=[];
// //   int _index=0;
// //   CheckPage(List<bool> _checked1,int _index1){_checked=_checked1;_index=_index1;}
// //
// //   @override
// //   CheckPageState createState() {
// //     return new CheckPageState(_checked,_index);
// //   }
// // }
// // class CheckPageState extends State<CategoryPage>{
// //   List<bool> _checked=[];
// //   int index=0;
// //   CheckPageState(List<bool> _checked1,int _index1){_checked=_checked1;index=_index1;}
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //    return  CheckboxListTile(
// //      // secondary: Icon(Icons.check,size: 200,),
// //
// //      value:_checked[index],
// //      activeColor:Colors.blue,
// //      checkColor:Colors.white,
// //      // tileColor:Colors.green,
// //      onChanged: (bool? value) {
// //        setState(() {
// //          _checked[index]=!_checked[index];
// //          // print("NewsFavoriteList$NewsFavoriteList");
// //        });
// //      },
// //    );
// //   }
// // }
// }
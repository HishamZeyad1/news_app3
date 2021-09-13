import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logout_problem_solution/Screens/Social/helper/news.dart';
import 'package:logout_problem_solution/models/category.dart';

import '../NavigationDrawer.dart';
import 'Social/helper/widget.dart';
import 'Social/view/categorie_news.dart';

class SocialMedia extends StatefulWidget {
  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia>with SingleTickerProviderStateMixin {
  late List<Category> categories;
  late ScrollController _controller;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  late bool _loading;
  var newslist;

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }



  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    categories = getCategories();
    getNews();
    _loading = true;
  }
  List<Category> getCategories(){

    List<Category> myCategories = <Category>[];
    Category categorieModel;
    //1
    String name="Business";
    String image="https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";

    categorieModel = new Category("1", name,image);
    myCategories.add(categorieModel);

    //2

    String name2="Entertainment";
    String image2 = "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
    categorieModel = new Category("2", name2,image2);
    myCategories.add(categorieModel);

    //3
    String name3="General";
    String image3 = "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60";
    categorieModel = new Category("3", name3,image3);
    myCategories.add(categorieModel);

    //4
    String name4 = "Health";
    String image4 = "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
    categorieModel = new Category("4", name4,image4);
    myCategories.add(categorieModel);

    //5
    String name5 = "Science";
    String image5= "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
    categorieModel = new Category("5", name5,image5);
    myCategories.add(categorieModel);

    //6
    String name6 = "Sports";
    String image6 = "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
    categorieModel = new Category("6", name6,image6);
    myCategories.add(categorieModel);

    //7
    String name7  = "Technology";
    String image7 = "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
    categorieModel = new Category("7", name7,image7);
    myCategories.add(categorieModel);

    return myCategories;

  }
  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }


  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);
    // late ScrollController _controller;
    // late TabController _tabController;

      return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          centerTitle: false,
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
                            _drawRecentUpdates(RandomColor(),categories[index],index),
                          ],
                        ),
                      );
                    },
                    itemCount: categories.length,

                    // onPageChanged: (index) {
                    //   _pageViewNotifier.value = index;
                    // },
                  ),
                ),)

            ]

        ),
      );


      // return Scaffold(
      //   appBar: AppBar(
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Text(
      //           "Flutter",
      //           style:
      //           TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      //         ),
      //         Text(
      //           "News",
      //           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
      //         )
      //       ],
      //     ),
      //     backgroundColor: Colors.transparent,
      //     elevation: 0.0,
      //   ),
      //   body:Container(
      //     padding: EdgeInsets.symmetric(horizontal: 16),
      //     height: 70,
      //     child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemCount: categories.length,
      //         itemBuilder: (context, index) {
      //           return CategoryCard(
      //             imageAssetUrl: categories[index].image,
      //             categoryName: categories[index].title,
      //           );
      //         }),
      //   ),
      // );


    // return Scaffold(
    //   appBar: AppBar(
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           "Flutter",
    //           style:
    //           TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
    //         ),
    //         Text(
    //           "News",
    //           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
    //         )
    //       ],
    //     ),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //   ),
    //   body: SafeArea(
    //     child: _loading
    //         ? Center(
    //       child: CircularProgressIndicator(),
    //     )
    //         : SingleChildScrollView(
    //       child: Container(
    //         child: Column(
    //           children: <Widget>[
    //             /// Categories
    //             Container(
    //               padding: EdgeInsets.symmetric(horizontal: 16),
    //               height: 70,
    //               child: ListView.builder(
    //                   scrollDirection: Axis.horizontal,
    //                   itemCount: categories.length,
    //                   itemBuilder: (context, index) {
    //                     return CategoryCard(
    //                       imageAssetUrl: categories[index].image,
    //                       categoryName: categories[index].title,
    //                     );
    //                   }),
    //             ),
    //
    //             /// News Article
    //             Container(
    //               margin: EdgeInsets.only(top: 16),
    //               child: ListView.builder(
    //                   itemCount: newslist.length,
    //                   shrinkWrap: true,
    //                   physics: ClampingScrollPhysics(),
    //                   itemBuilder: (context, index) {
    //                     return NewsTile(
    //                       imgUrl: newslist[index].urlToImage ?? "",
    //                       title: newslist[index].title ?? "",
    //                       desc: newslist[index].description ?? "",
    //                       content: newslist[index].content ?? "",
    //                       posturl: newslist[index].articleUrl ?? "",
    //                     );
    //                   }),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
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
                // return Container();

                return CategoryNews(
                  newsCategory: category.title.toLowerCase(),
                );
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
                      image: NetworkImage( category.image ),
                      // image: ExactAssetImage(category.image),
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


class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({required this.imageAssetUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              newsCategory: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

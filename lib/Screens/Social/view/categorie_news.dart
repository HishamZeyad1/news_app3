import 'package:flutter/material.dart';
import 'package:logout_problem_solution/NavigationDrawer.dart';
import 'package:logout_problem_solution/Screens/Social/helper/news.dart';
import 'package:logout_problem_solution/Screens/Social/helper/widget.dart';


class CategoryNews extends StatefulWidget {

  final String newsCategory;

  CategoryNews({required this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;
  late ScrollController _controller;
  // late TabController _tabController;


  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }

  @override
  void initState() {
    _controller = ScrollController();
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        // actions: <Widget>[
        //   Opacity(
        //     opacity: 1,
        //     child: Container(
        //         padding: EdgeInsets.symmetric(horizontal: 16),
        //         child: Icon(Icons.share,)),
        //   )
        // ],
        backgroundColor: Colors.blue,
        // elevation: 0.0,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : Scaffold(
        body: Scrollbar(
          isAlwaysShown: true,
          controller: _controller,
            child: Container(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _controller,
                      itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return  NewsTile(
                            imgUrl: newslist[index].urlToImage ?? "",
                            title: newslist[index].title ?? "",
                            desc: newslist[index].description ?? "",
                            content: newslist[index].content ?? "",
                            posturl: newslist[index].articleUrl ?? "",

                        );
                      }),
                ),
              ),
          ),
        ),
      // drawer: NavigationDrawer(),

    );
  }
}
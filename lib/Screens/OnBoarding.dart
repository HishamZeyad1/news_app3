import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logout_problem_solution/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "package:page_view_indicator/page_view_indicator.dart";
import '../PageModel.dart';
// import 'home_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late List<PageModel> pages;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  PageController _controller = PageController(
      initialPage: 0,
      viewportFraction: 0.8
  );
  PageController pageController = PageController();
  // this is like a lock that prevent update the PageView multiple times while is
  // scrolling
  bool pageIsScrolling = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void _addPages() {
    pages = <PageModel>[];
    pages.add(PageModel('Welcome',
        '1- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit, 'assets/images/bg.png'));
    pages.add(PageModel('Alarm',
        '2- Making friends is easy as waving your hand back and forth in easy step',
        Icons.access_alarms, 'assets/images/bg3.png'));
    pages.add(PageModel('Print',
        '3- Making friends is easy as waving your hand back and forth in easy step',
        Icons.map, 'assets/images/bg.png'));
    pages.add(PageModel('Map',
        '4- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit, 'assets/images/bg4.png'));
  }
int indexN=0;
  @override
  Widget build(BuildContext context) {
    _addPages();
    // return Stack(
    //   children: <Widget>[
    //     Scaffold(
    //       body: PageView.builder(
    //         // ignore: missing_return
    //         controller: _controller,
    //         scrollDirection: Axis.horizontal,
    //         physics: NeverScrollableScrollPhysics(),
    //         pageSnapping: true,
    //         children: <Widget>[
    //           Container(color: Colors.red),
    //           Container(color: Colors.blue),
    //           Container(color: Colors.orange),
    //         ],
    //
    //         // itemBuilder: (context, index) {
    //         //   return Stack(
    //         //     children: [
    //         //       Container(
    //         //         decoration: BoxDecoration(
    //         //             image: DecorationImage(
    //         //               image: ExactAssetImage(pages[ index ].image),
    //         //               fit: BoxFit.cover,
    //         //             )),
    //         //       ),
    //         //       Column(
    //         //         crossAxisAlignment: CrossAxisAlignment.center,
    //         //         mainAxisAlignment: MainAxisAlignment.center,
    //         //         children: [
    //         //           Transform.translate(
    //         //             child: Icon(
    //         //               pages[ index ].icon,
    //         //               size: 100,
    //         //               color: Colors.white,
    //         //             ),
    //         //             offset: Offset(0, -50),
    //         //           ),
    //         //           Text(
    //         //             pages[index].title,
    //         //             style: TextStyle(
    //         //               color: Colors.white,
    //         //               fontSize: 28,
    //         //               fontWeight: FontWeight.bold,
    //         //             ),
    //         //             textAlign: TextAlign.center,
    //         //
    //         //           ),
    //         //           Padding(
    //         //             padding: const EdgeInsets.only(
    //         //                 left: 48, right: 48, top: 18),
    //         //             child: Text(
    //         //               pages[ index ].description,
    //         //               style: TextStyle(
    //         //                 color: Colors.grey,
    //         //                 fontSize: 16,
    //         //               ),
    //         //               textAlign: TextAlign.center,
    //         //             ),
    //         //           ),
    //         //         ],
    //         //       ),
    //         //     ],
    //         //   );
    //         // },
    //         itemCount: pages.length,
    //         onPageChanged: (index) {
    //           _pageViewNotifier.value = index;
    //         },
    //
    //       ),
    //     ),
    //     Transform.translate(
    //       offset: Offset(0, 175),
    //       child: Align(
    //         alignment: Alignment.center,
    //         child: _displayPageIndicators(pages.length),
    //       ),
    //     ),
    //     Align(
    //       alignment: Alignment.bottomCenter,
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
    //         child: SizedBox(
    //           width: double.infinity,
    //           height: 50,
    //           child: RaisedButton(
    //             color: Colors.red.shade900,
    //             child: Text(
    //               'GET STARTED',
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 16,
    //                 letterSpacing: 1,
    //               ),
    //             ),
    //             onPressed: () {
    //               // _updateSeen();
    //
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) {
    //                     return HomeScreen();
    //                   },
    //                 ),
    //               );
    //
    //             },
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return Scaffold(

      body: SafeArea(
          child: GestureDetector(

            // to detect swipe
            onPanUpdate: (details) {
              print("****details*******");
              print(details.localPosition.direction);
              // if(indexN<pages.length){
              // _onScroll(pointerSignal.scrollDelta.dy);}
              _onScroll(details.delta.dx * -1);
              // print(index);

            },
            child: Listener(
              // to detect scroll
              onPointerSignal: (pointerSignal) {
                if (pointerSignal is PointerScrollEvent) {
                  // if(index<=pages.length-1){index+=1;}
                  _onScroll(pointerSignal.scrollDelta.dx);
                }
              },
              child: Stack(
                children: [       PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  // physics: NeverScrollableScrollPhysics(),
                  // pageSnapping: true,
                  itemBuilder: (context, index) {
                    // return Container(color: Colors.red);
                    // Container(color: Colors.blue),
                    // Container(color: Colors.orange),

                    indexN++;
                    print("*****************************");
                    print(indexN);
                    if(index>pages.length-1){return Card();}
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage(pages[ index ].image),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.translate(
                              child: Icon(
                                pages[ index ].icon,
                                size: 100,
                                color: Colors.white,
                              ),
                              offset: Offset(0, -50),
                            ),
                            Text(
                              pages[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 48, right: 48, top: 18),
                              child: Text(
                                pages[ index ].description,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],);
                  },
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    _pageViewNotifier.value = index;
                  },
                ),

                  Transform.translate(
                    offset: Offset(0, 175),
                    child: Align(
                      alignment: Alignment.center,
                      child: _displayPageIndicators(pages.length),
                    ),
                  ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: RaisedButton(
                              color: Colors.red.shade900,
                              child: Text(
                                'GET STARTED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                              onPressed: () {
                                // _updateSeen();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomeScreen();
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        ),
                      ),

                ],


              ),
            ),
          )),
    );
  }

  void _onScroll(double offset) {
    // print("_onScroll");
    //
    // indexN=indexN+1;
    // print(indexN);


    if (pageIsScrolling == false) {
      pageIsScrolling = true;
      if (offset > 0) {
        pageController
            .nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut)
            .then((value) => pageIsScrolling = false);

        print('scroll down');
      } else {
        pageController
            .previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut)
            .then((value) => pageIsScrolling = false,);
        print('scroll up');
      }
    }
  }

  Widget _displayPageIndicators(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) =>
          CircleAvatar(
            child:SizedBox(
            ),
            radius:8,
            backgroundColor: Colors.grey,
          ),
      highlightedBuilder: (animationController, index) =>
          ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: CircleAvatar(
              child:SizedBox(
              ),
              radius:10,
              backgroundColor: Colors.red,
            ),
          ),
    );
  }

// void _updateSeen() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool( 'seen' , true);
// }
}
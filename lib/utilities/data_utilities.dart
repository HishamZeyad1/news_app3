import 'package:flutter/material.dart';
// import 'package:timeago/timeago.dart' as timeago;

Widget connectionError() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('Connection Error!!!!'),
  );
}

Widget error(var error) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text(error.toString()),
  );
}

Widget noData() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('No Data Available!'),
  );
}

Widget loading() {
  return Container(
    padding: EdgeInsets.only(top: 16, bottom: 16),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

String parseHumanDateTime(String dateTime) {
  Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
  DateTime theDifference = DateTime.now().subtract(timeAgo);
  int days=timeAgo.inDays;
// print("days:$days");
  int y=days~/365;//print("y:$y");
  int m=(days-(y*365))~/30;//print("m:$m");
  int d=days-(y*365+m*30);//print("d:$d");
  int h=theDifference.hour;//print("h:$h");
  int sec=theDifference.second;//print("sec:$sec");
  String str="";

  if(y!=0){
    String s= y==1?"year":"years";
    str+="$y $s";
    // print(s);
  }else if(m!=0){
    String s= m==1?"month":"months";
    str+="$m $s";
    // print(s);
  }else if(d!=0){
    String s= d==1?"day":"days";
    str+="$d $s";
    // print(s);
  }else if(h!=0){
    String s= h==1?"hour":"hours";
    str+="$h $s";
  }else if(sec!=0){
    String s= sec==1?"second":"seconds";
    str+="$sec $s";
  }
  print("s:$str");
  return str;
  // return timeAgo.inDays.toString();
  // return timeago.format(theDifference);
}
import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/models/category.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';
import 'dart:convert';
class CategoriesAPI {
  int i=0,length=0;
  late String categoriesUrl;
  var url,response;
  late Map<String,String> headers;
  CategoriesAPI(){
    categoriesUrl = base_api + all_categories_api;
    url = Uri.parse(categoriesUrl);
    headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    ss();
  }
  Future<void> ss() async {     response = await http.get( url,headers:headers);}
  Future<int?> getLength() async {
    if( response.statusCode == 200 ){
      var jsondata = jsonDecode( response.body );
      final int length = jsondata.length??0;
      return length;}
  }
  Future< List<Category> > fetchCategories() async {
    late int i=0;
    List<Category> categories = <Category>[];
    var response = await http.get( url,headers:headers);
    if( response.statusCode == 200 ){
      var jsondata = jsonDecode( response.body );final length = jsondata.length;

      var data = jsondata["data"];
      print("****************************");
      for( var item in data ){
        Category category = Category( item["id"].toString() , item["name"].toString(),item["avatar"].toString());
        categories.add( category );
        ++i;
        this.i=i;
        print( category.title );
      }
      this.length=i;
      print("****************************");
    }
    return categories;
  }

  Future<Category> fetchCategory(String id) async {
    late int i=0;
    Category category = new Category("1", "Sport");

    categoriesUrl = base_api + Category_api+id;
    url = Uri.parse(categoriesUrl);
    headers = {
      "Accept" : "application/json",
      "Content-Type" : "application/x-www-form-urlencoded",
    };
    var response = await http.get( url,headers:headers);
    if( response.statusCode == 200 ){
      var jsondata = jsonDecode( response.body );final length = jsondata.length;

      // var data = jsondata["data"];
      print("****************************");
      // for( var item in data ){
        category = Category( jsondata["id"].toString() , jsondata["name"].toString(),jsondata["avatar"].toString());
        // categories.add( category );
        // ++i;
        // this.i=i;
        // print( category.title );
      }
      this.length=i;
      print("****************************");
    // }
    return category;
  }




}
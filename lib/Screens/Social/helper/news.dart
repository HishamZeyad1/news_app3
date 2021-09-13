import 'package:http/http.dart' as http;
import 'package:logout_problem_solution/Screens/Social/model/article.dart';
import 'package:logout_problem_solution/models/category.dart';
import 'package:logout_problem_solution/utilities/api_utilities.dart';
import 'dart:convert';


class News {

  List<Article> news  = [];
  Category getCategories(int id){

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

    return myCategories[id];

  }

  Future<void> getNews() async{

    String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apiKey}";
    var url2 = Uri.parse(url);

    var response = await http.get(url2);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }

  Future<List<Article>> fetchAllArticles(int id) async {
    List<Article> news  = [];
    String url;
    switch(id){https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=API_KEY
      case 1:url="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${apiKey}";break;
      case 2:url="https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=${apiKey}";break;
      case 3:url="https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=${apiKey}";break;
      case 4:url="https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=${apiKey}";break;
      case 5:url="https://https://newsapi.org/v2/top-headlines?country=us&category=sport&apiKey=${apiKey}";break;
      case 6:url="https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=${apiKey}";break;
      default:url="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${apiKey}";
    }

    // String allAuthorsApi = base_api + all_authors_api;
    var url2 = Uri.parse(url);
    var response = await http.get(url2);
    // var url = Uri.parse(allAuthorsApi); print("*****************");//192.168.42.6
    // var response = await http.get(url);    // var response = await http.get(allAuthorsApi);
    // print(response.statusCode);    print("*****************"); print(response.body);//192.168.42.6\newsapp_api/public/api/authors

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
    return news;
  }

}


class NewsForCategorie {

  List<Article> news  = [];

  Future<void> getNewsForCategory(String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apiKey}";
    var url2 = Uri.parse(url);
    var response = await http.get(url2);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}

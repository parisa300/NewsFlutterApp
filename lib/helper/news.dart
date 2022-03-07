
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news/models/article_model.dart';
class News{
  static Future< List<ArticleModel>> getNews() async {
    try{
      List<ArticleModel> news = [];
      String url =
          "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=23e20be22e7742c2b4e22e71f6603d21";
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == "ok") {
        jsonData["articles"].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel article = ArticleModel(
              author: element['author'] ?? 'No Author',
              title: element['title'],
              description: element['description'],
              url: element["url"],
              urlToImage: element['urlToImage'],
              content: element["content"] ?? 'No Content',
            );
            news.add(article);
          }
        });
      }
      return news;
    }
    catch(e, st){
      log('ERROR: $e', stackTrace: st);
      rethrow;
    }
  }
}

/*class NewsForCategorie{
  static Future< List<ArticleModel>> getNewsForCategory(String category) async {
    try{
      List<ArticleModel> news = [];
      String url =
          "http://newsapi.org/v2/top-headlines?category$category&country=in&category=business&apiKey=23e20be22e7742c2b4e22e71f6603d21";
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == "ok") {
        jsonData["articles"].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            ArticleModel article = ArticleModel(
              author: element['author'] ?? 'No Author',
              title: element['title'],
              description: element['description'],
              url: element["url"],
              urlToImage: element['urlToImage'],
              content: element["content"] ?? 'No Content',
            );
            news.add(article);
          }
        });
      }
      return news;
    }
    catch(e, st){
      log('ERROR: $e', stackTrace: st);
      rethrow;
    }
  }
}*/
class NewsForCategorie {

  List<ArticleModel> news = [];

  Future<void> getNewsForCategory(String category) async {
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=23e20be22e7742c2b4e22e71f6603d21";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
            author: element['author'] ?? 'No Author',
            title: element['title'],
            description: element['description'],
            url: element["url"],
            urlToImage: element['urlToImage'],
            content: element["content"] ?? 'No Content',
          );
          news.add(article);
        }
      });
    }
  }
}



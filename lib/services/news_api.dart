import 'package:flutter_fluent_ui_app/models/article.dart';
import 'package:flutter_fluent_ui_app/models/article_category.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  const NewsApi();

  static const baseURL = 'https://newsapi.org/v2';
  static const apiKey = '3018e1d00c7a49589a7792bd65a3aac3';

  Future<List<Article>> fetchArticles(ArticleCategory category) {
    var url = baseURL;
    url += '/top-headlines';
    url += '?apiKey=$apiKey';
    url += '&language=en';
    url += '&category=${categoryQueryParamValue(category)}';
  }

  String categoryQueryParamValue(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.general:
        return "general";
      case ArticleCategory.business:
        return "business";
      case ArticleCategory.technology:
        return "technology";
      case ArticleCategory.entertainment:
        return "entertainment";
      case ArticleCategory.sports:
        return "sports";
      case ArticleCategory.science:
        return "science";
      case ArticleCategory.health:
        return "health";
      default:
        return "general";
    }
  }
}

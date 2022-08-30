import 'dart:convert';
import 'dart:io';

import 'package:flutter_fluent_ui_app/models/article.dart';
import 'package:flutter_fluent_ui_app/models/article_category.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  const NewsApi();

  static const baseURL = 'https://newsapi.org/v2';
  static const apiKey = '3018e1d00c7a49589a7792bd65a3aac3';

  Future<List<Article>> fetchArticles(ArticleCategory category) async {
    var url = baseURL;
    url += '/top-headlines';
    url += '?apiKey=$apiKey';
    url += '&language=en';
    url += '&category=${category.toShortString()}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load articles (bad response)');
    }

    final json = jsonDecode(response.body);
    if (json['status'] != 'ok') {
      throw Exception(json['message'] ?? 'Failed to load articles');
    }

    final dynamic articlesJSON = json['articles'] ?? [];
    final List<Article> articles =
        articlesJSON.map<Article>((e) => Article.fromJson(e)).toList();
    return articles;
  }
}

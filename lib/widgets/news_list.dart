import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_fluent_ui_app/models/article.dart';
import 'package:flutter_fluent_ui_app/models/news_page.dart';
import 'package:flutter_fluent_ui_app/services/news_api.dart';
import 'package:flutter/material.dart' as material;

import 'news_item.dart';

class NewsListPage extends StatefulWidget {
  final NewsPage newsPage;
  final NewsApi newsApi = const NewsApi();

  const NewsListPage({Key? key, required this.newsPage}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = widget.newsApi.fetchArticles(widget.newsPage.category);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(widget.newsPage.title),
      ),
      content: FutureBuilder<List<Article>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 270,
                mainAxisExtent: 290,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return NewsItem(
                  article: snapshot.data![index],
                );
              }),
            );
          } else if (snapshot.hasError) {
            Typography typography = FluentTheme.of(context).typography;
            return Column(
              children: [
                const Spacer(),
                Center(
                  child: Text(
                    '${snapshot.error}',
                    style: typography.bodyStrong,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FilledButton(
                  child: const Text('Refesh'),
                  onPressed: () {
                    setState(() {
                      futureArticles = widget.newsApi
                          .fetchArticles(widget.newsPage.category);
                    });
                  },
                ),
                const Spacer(),
              ],
            );
          }

          return const Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: material.CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

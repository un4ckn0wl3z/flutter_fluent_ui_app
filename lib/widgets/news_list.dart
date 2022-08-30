import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_fluent_ui_app/models/news_page.dart';

import 'news_item.dart';

class NewsListPage extends StatefulWidget {
  final NewsPage newsPage;
  const NewsListPage({Key? key, required this.newsPage}) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(widget.newsPage.title),
      ),
      content: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 270,
          mainAxisExtent: 290,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: ((context, index) {
          return NewsItem();
        }),
      ),
    );
  }
}

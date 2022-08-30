import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_fluent_ui_app/models/article_category.dart';
import 'package:flutter_fluent_ui_app/models/news_page.dart';
import 'package:flutter_fluent_ui_app/widgets/news_list.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitle('News App');
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setSize(const Size(755, 545));
    await windowManager.setMinimumSize(const Size(755, 545));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'News App',
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.orange,
      ),
      home: const MyHomePage(
        title: 'News App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  int paneIndex = 0;
  final viewKey = GlobalKey();
  final List<NewsPage> pages = const [
    NewsPage(
        title: 'Top Headlines',
        iconData: FluentIcons.news,
        category: ArticleCategory.general),
    NewsPage(
        title: 'Business',
        iconData: FluentIcons.business_center_logo,
        category: ArticleCategory.business),
    NewsPage(
        title: 'Technology',
        iconData: FluentIcons.laptop_secure,
        category: ArticleCategory.technology),
    NewsPage(
        title: 'Entertainment',
        iconData: FluentIcons.my_movies_t_v,
        category: ArticleCategory.entertainment),
    NewsPage(
        title: 'Sports',
        iconData: FluentIcons.more_sports,
        category: ArticleCategory.sports),
    NewsPage(
        title: 'Science',
        iconData: FluentIcons.communications,
        category: ArticleCategory.science),
    NewsPage(
        title: 'Health',
        iconData: FluentIcons.health,
        category: ArticleCategory.health)
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);

    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();

    if (isPreventClose) {
      showDialog(
          context: context,
          builder: (_) {
            return ContentDialog(
              title: const Text('Confirm close'),
              content: const Text('Are you sure want to close the app?'),
              actions: [
                FilledButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.pop(context);
                      windowManager.destroy();
                    }),
                FilledButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
        selected: paneIndex,
        onChanged: (index) {
          setState(() {
            paneIndex = index;
          });
        },
        displayMode: PaneDisplayMode.compact,
        items: pages.map<NavigationPaneItem>((e) {
          return PaneItem(
            title: Text(e.title),
            icon: Icon(e.iconData),
          );
        }).toList(),
      ),
      content: NavigationBody.builder(
          index: paneIndex,
          itemBuilder: (context, index) {
            return NewsListPage(newsPage: pages[index]);
          }),
    );
  }
}

import 'package:daily_prophet_flutter/features/news/models/article.dart';
import 'package:daily_prophet_flutter/features/news/stores/news_store.dart';
import 'package:daily_prophet_flutter/features/news/widgets/article_list_item.dart';
import 'package:daily_prophet_flutter/features/news/widgets/headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class NewsListView extends StatefulWidget {
  static const String routeName = '/news-list-view';
  const NewsListView({Key key}) : super(key: key);

  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _pageController.addListener(_handlePageChange);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      NewsStore _newsStore = Provider.of<NewsStore>(context, listen: false);
      _newsStore.getTopNewsList(context: context);
      _newsStore.getLiverpoolNewsList(context: context);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_handlePageChange);
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentIndex = _pageController.page.round();
    });
  }

  static const List<String> tabs = [
    'Popular Articles',
    'Liverpool FC Articles',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsStore>(builder: (context, _newsStore, child) {
      return Scaffold(
        appBar: AppBar(
          title: Headline(
            text: tabs[_currentIndex],
            index: _currentIndex,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              ListView.builder(
                itemCount: _newsStore.topArticles.length,
                itemBuilder: (context, index) {
                  Article article = _newsStore.topArticles[index];
                  return ArticleListItem(
                      title: article.title, description: article.description);
                },
              ),
              ListView.builder(
                itemCount: _newsStore.liverpoolArticles.length,
                itemBuilder: (context, index) {
                  Article article = _newsStore.liverpoolArticles[index];
                  return ArticleListItem(
                      title: article.title, description: article.description);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              title: Text(tabs[0]),
              icon: Icon(Icons.star_border),
            ),
            BottomNavigationBarItem(
              title: Text(tabs[1]),
              icon: Icon(Icons.new_releases),
            )
          ],
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic);
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      );
    });
  }
}

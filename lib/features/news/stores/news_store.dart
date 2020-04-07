import 'package:daily_prophet_flutter/core/stores/base_store.dart';
import 'package:daily_prophet_flutter/features/news/models/article.dart';
import 'package:daily_prophet_flutter/features/news/response_models/news_response.dart';
import 'package:daily_prophet_flutter/features/news/services/news_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class NewsStore extends BaseStore with ChangeNotifier {
  final NewsService _newsService = NewsService();
  final client = Client();

  List<Article> topArticles = List<Article>();
  List<Article> liverpoolArticles = List<Article>();

  Future<List<Article>> getTopNewsList({
    @required BuildContext context,
  }) async {
    try {
      NewsResponse newsResponse = await _newsService.topNewsList(client);

      topArticles = newsResponse.articles;
      notifyListeners();
    } on Exception catch (error) {
      final errorMessage = error.toString();

      commonStore.showErrorSnackbar(
        context: context,
        title: 'Failed to load news articles',
        errorMessage: errorMessage,
      );
    }

    return topArticles;
  }

  Future<List<Article>> getLiverpoolNewsList({
    @required BuildContext context,
  }) async {
    try {
      NewsResponse newsResponse = await _newsService.liverpoolNewsList(client);

      liverpoolArticles = newsResponse.articles;
      notifyListeners();
    } on Exception catch (error) {
      final errorMessage = error.toString();

      commonStore.showErrorSnackbar(
        context: context,
        title: 'Failed to load news articles',
        errorMessage: errorMessage,
      );
    }

    return liverpoolArticles;
  }
}

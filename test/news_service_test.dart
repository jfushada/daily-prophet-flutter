import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:daily_prophet_flutter/features/news/response_models/news_response.dart';
import 'package:daily_prophet_flutter/features/news/services/news_service.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('get articles', () {
    test('returns list of articles if the http call completes successfully',
        () async {
      final client = MockClient();

      when(
        client.get(
          'http://newsapi.org/v2/top-headlines?country=us&apiKey=fdec3af7ebbb4a8e90dbf26b1517cbe6',
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"status": "ok", "totalResults": 10, "articles": [{"title": "test"}]}',
          200,
        ),
      );

      expect(
        await NewsService().topNewsList(client),
        const TypeMatcher<NewsResponse>(),
      );
    });

    // test('dummy fail test', () {
    //   expect(true, false);
    // });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(
        client.get(
          'http://newsapi.org/v2/top-headlines?country=us&apiKey=fdec3af7ebbb4a8e90dbf26b1517cbe6',
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(NewsService().topNewsList(client), throwsException);
    });
  });
}

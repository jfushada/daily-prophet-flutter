import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:daily_prophet_flutter/features/news/response_models/news_response.dart';
import 'package:daily_prophet_flutter/features/news/services/news_service.dart';

/// Generally you want unit tests to be fast and tightly scoped, and kind of simple in that you have an input, and you want to get a particular output. 
/// One thing that you want to stay away from in a unit test is that you don’t want anything that relies on external resources, that isn’t part of your code.
 
/// In this test, if you just actually made a http call, the test could fail anytime in the future, if you’re not connected, for example. 
/// Try to isolate things outside of your control, and just focus on what you do with it. 

/// So instead of making an actual http call, here I’m mocking it by using a package called mockito - a mock library for dart inspired by the Java version. 
/// The function I'm mocking is in the NewsService, called topNewsList, and for testing purposes, I’m sending the http client as a parameter, so I can mock it in the test. 
/// The MockClient class implements the http.Client class. This allows you to pass the MockClient to the topNewsList function, and return different http responses in each test. 
/// The function basically has two results - if it succeeds, it returns the News Response, which is a model based on NewsApi, and if it fails, it throws an exception. 

/// The conditions are tested using the when function - it’s using the mock client to get the responses, and then returns a successful response, which we expect to be of type NewsResponse. 
/// In the failure case, we feed it with an error, with status code 404, and we expect that it throws an exception.

/// You can also see here that you can group tests - the ones that are related. 
/// These tests will run in order, and if one fails, you’ll see that the group name precedes the test name, so you can find the exact one you’re looking at so you’re not confused.

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

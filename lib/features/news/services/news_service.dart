import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:daily_prophet_flutter/features/news/response_models/news_response.dart';

class NewsService {
  final String baseUrl = 'http://newsapi.org/v2';
  final String apiKey = 'fdec3af7ebbb4a8e90dbf26b1517cbe6';

  Future<NewsResponse> topNewsList(Client client) async {
    Response response = await client.get(
      Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Whoops, something went wrong.');
    }
  }

  Future<NewsResponse> liverpoolNewsList(Client client) async {
    Response response = await client.get(
      Uri.parse('$baseUrl/everything?q=liverpool&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Whoops, something went wrong.');
    }
  }
}

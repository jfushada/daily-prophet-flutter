import 'dart:convert';

import 'package:daily_prophet_flutter/features/news/models/source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(this.source, this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  String toString() {
    return 'Article{source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}';
  }
}

List<int> parseArticleIds(String jsonString) {
  var parsed = jsonDecode(jsonString);
  var listOfArticleIds = List<int>.from(parsed);
  return listOfArticleIds;
}

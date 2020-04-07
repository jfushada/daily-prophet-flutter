import 'package:daily_prophet_flutter/features/news/models/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse {
  String status;
  int totalResults;
  List<Article> articles;
  @JsonKey(ignore: true)
  String error;

  NewsResponse(this.status, this.totalResults, this.articles);

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  NewsResponse.withError(this.error);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);

  @override
  String toString() {
    return 'NewsResponse{status: $status, totalResults: $totalResults, articles: $articles, error: $error}';
  }
}

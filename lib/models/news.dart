import 'dart:convert';

class News {
  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  // ignore: sort_constructors_first
  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  // ignore: sort_constructors_first
  factory News.fromJson(Map<String, dynamic> json) {
    List<Article> _tempList = <Article>[];
    json['articles'].forEach((dynamic e) {
      _tempList.add(Article.fromJson(e));
    });

    return News(
      status: json['status'].toString(),
      totalResults: int.parse(json['totalResults'].toString()),
      articles: _tempList,
    );
  }
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  // ignore: sort_constructors_first
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      url: json['url'].toString(),
      urlToImage: json['urlToImage'].toString(),
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'].toString(),
    );
  }
}

class Source {
  Source({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  // ignore: sort_constructors_first
  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json['id'].toString(),
        name: json['name'].toString(),
      );
}

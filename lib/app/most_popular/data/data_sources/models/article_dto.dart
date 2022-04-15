import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:nytimes/app/most_popular/domain/entities/media.dart';

class ArticleDTO {
  ArticleDTO({
    required this.url,
    required this.id,
    required this.source,
    required this.publishedDate,
    required this.updated,
    required this.section,
    required this.byline,
    required this.type,
    required this.title,
    required this.articleAbstract,
    required this.media,
  });

  final String url;
  final int id;
  final String source;
  final String publishedDate;
  final String updated;
  final String section;
  final String byline;
  final String type;
  final String title;
  final String articleAbstract;
  final List<dynamic> media;

  factory ArticleDTO.fromMap(Map<String, dynamic> map) {
    return ArticleDTO(
      url: map['url'],
      id: map['id'],
      source: map['source'],
      publishedDate: map['published_date'],
      updated: map['updated'],
      section: map['section'],
      byline: map['byline'],
      type: map['type'],
      title: map['title'],
      articleAbstract: map['abstract'],
      media: map['media'],
    );
  }

  Article toModel() {
    return Article(
      url: url,
      id: id,
      source: source,
      publishedDate: DateTime.parse(publishedDate),
      updated: DateTime.parse(updated),
      section: section,
      byline: byline,
      type: type,
      title: title,
      articleAbstract: articleAbstract,
      media: media.map((e) => Media.fromJson(e)).toList(),
    );
  }
}

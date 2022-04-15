import 'media.dart';
import 'package:collection/collection.dart';

class Article {
  Article({
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
  final DateTime publishedDate;
  final DateTime updated;
  final String section;
  final String byline;
  final String type;
  final String title;
  final String articleAbstract;
  final List<Media> media;

  Media? image() {
    return media.firstWhereOrNull((element) => element.type == 'image');
  }
}

extension ArticleExt on Article {
  MediaMetadata? get thumb {
    return image()
        ?.mediaMetadata
        .firstWhere((element) => element.format == MediaType.thumbnail);
  }

  MediaMetadata? get image210 {
    return image()?.mediaMetadata.firstWhere(
        (element) => element.format == MediaType.mediumThreeByTwo210);
  }

  MediaMetadata? get image440 {
    return image()?.mediaMetadata.firstWhere(
        (element) => element.format == MediaType.mediumThreeByTwo440);
  }
}

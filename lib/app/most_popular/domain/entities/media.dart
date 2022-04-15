class Media {
  Media({
    required this.type,
    required this.caption,
    required this.mediaMetadata,
  });

  final String type;

  final String caption;

  final List<MediaMetadata> mediaMetadata;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: json["type"],
        caption: json["caption"],
        mediaMetadata: List<MediaMetadata>.from(
            json["media-metadata"].map((x) => MediaMetadata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "media-metadata":
            List<dynamic>.from(mediaMetadata.map((x) => x.toJson())),
      };
}

class MediaMetadata {
  MediaMetadata({
    required this.url,
    required this.format,
  });

  final String url;
  final MediaType format;

  factory MediaMetadata.fromJson(Map<String, dynamic> json) => MediaMetadata(
        url: json["url"],
        format: mapNames()[json['format']]!,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "format": format,
      };
}

enum MediaType {
  thumbnail,
  mediumThreeByTwo210,
  mediumThreeByTwo440,
}

extension MediaTypeEx on MediaType {
  String get name {
    switch (this) {
      case MediaType.thumbnail:
        return 'Standard Thumbnail';
      case MediaType.mediumThreeByTwo210:
        return 'mediumThreeByTwo210';
      case MediaType.mediumThreeByTwo440:
        return 'mediumThreeByTwo440';
    }
  }
}

Map<String, MediaType> mapNames() {
  return Map.fromEntries(MediaType.values.map((e) => MapEntry(e.name, e)));
}

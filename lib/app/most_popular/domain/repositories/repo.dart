import 'package:core/core.dart';

import '../entities/article.dart';

abstract class IMostPopularRepo {
  Future<List<Article>> getMostPopularArticles(Params params);
}

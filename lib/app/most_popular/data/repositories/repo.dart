import 'package:core/core.dart';
import 'package:nytimes/app/most_popular/data/data_sources/remote/remote.dart';
import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:nytimes/app/most_popular/domain/repositories/repo.dart';

class MostPopularRepo extends IMostPopularRepo {
  final MostPopularRemote _remote;

  MostPopularRepo(this._remote);

  @override
  Future<List<Article>> getMostPopularArticles(Params params) {
    return _remote
        .getMostPopular(params)
        .then((value) => value.map((e) => e.toModel()).toList());
  }
}

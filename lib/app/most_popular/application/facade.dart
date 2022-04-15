import 'package:core/core.dart';
import 'package:network/api_result.dart';
import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:nytimes/app/most_popular/domain/repositories/repo.dart';

class MostPopularFacade {
  MostPopularFacade(this._mostPopularRepo);

  final IMostPopularRepo _mostPopularRepo;

  Future<ApiResult<List<Article>>> getMostPopularArticles(Params params) async {
    return toApiResult(
      () => _mostPopularRepo.getMostPopularArticles(params),
    );
  }
}

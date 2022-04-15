import 'package:core/core.dart';
import 'package:network/p_http_client.dart';
import 'package:nytimes/app/most_popular/data/data_sources/models/article_dto.dart';

class MostPopularRemote {
  final Dio _dio;

  MostPopularRemote(this._dio);

  Future<List<ArticleDTO>> getMostPopular(Params params) async {
    final paramsMap = params.toMap();
    final period = paramsMap['period'];
    final section = paramsMap['section'];
    final endPoint = '/mostpopular/v2/mostviewed/$section/$period.json';

    final response = await _dio.get(
      endPoint,
      cancelToken: params.cancelToken,
    );

    final List data = response.data['results'] ?? [];

    return throwAppException(
      () => data.map((e) => ArticleDTO.fromMap(e)).toList(),
    );
  }
}

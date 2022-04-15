import 'package:nytimes/app/most_popular/application/facade.dart';
import 'package:nytimes/app/most_popular/data/data_sources/remote/remote.dart';
import 'package:nytimes/app/most_popular/data/repositories/repo.dart';
import 'package:nytimes/app/most_popular/domain/repositories/repo.dart';
import 'package:nytimes/locator/locator.dart';

void mostPopular() {
  locator.registerLazySingleton(() => MostPopularRemote(locator()));
  locator.registerLazySingleton<IMostPopularRepo>(
      () => MostPopularRepo(locator()));
  locator.registerLazySingleton(() => MostPopularFacade(locator()));
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nytimes/app/most_popular/application/facade.dart';
import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:nytimes/app/most_popular/domain/params/params.dart';
import 'package:nytimes/app/most_popular/domain/repositories/repo.dart';
import 'package:nytimes/app/most_popular/presentation/manager/most_popular_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockMostPopularRepo implements IMostPopularRepo {
  @override
  Future<List<Article>> getMostPopularArticles(Params params) async {
    return const [];
  }
}

void main() {
  group(
    'Most popular bloc test',
    () {
      late MostPopularBloc bloc;
      late MockMostPopularRepo repo;

      setUp(() {
        EquatableConfig.stringify = true;
        repo = MockMostPopularRepo();
        bloc = MostPopularBloc(MostPopularFacade(repo));
      });

      blocTest<MostPopularBloc, MostPopularState>(
        'should emit [Loading, Loaded] when [MostPopularStarted] is called',
        build: () => bloc,
        act: (bloc) async {
          bloc.add(MostPopularStarted());
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MostPopularState.loading(
            period: Period.daily,
          ),
          MostPopularState.loaded(
            period: Period.daily,
            pageState: const PageState.loaded(
              data: [],
            ),
          ),
        ],
      );

      tearDown(
        (() {
          bloc.close();
        }),
      );
    },
  );
}

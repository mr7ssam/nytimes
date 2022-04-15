import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nytimes/app/most_popular/application/facade.dart';
import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:nytimes/app/most_popular/domain/params/params.dart';
import 'package:nytimes/common/mixin.dart';

part 'most_popular_event.dart';

part 'most_popular_state.dart';

class MostPopularBloc extends Bloc<MostPopularEvent, MostPopularState>
    with RetryBlocMixin {
  MostPopularBloc(this._facade) : super(MostPopularState.init()) {
    on<MostPopularEvent>(_handler);
  }

  final MostPopularFacade _facade;

  FutureOr<void> _handler(
      MostPopularEvent event, Emitter<MostPopularState> emit) async {
    if (event is MostPopularStarted) {
      await _fetch(emit);
    } else if (event is PeriodChanged) {
      await _fetch(emit, period: event.period);
    }
  }

  Future<void> _fetch(
    Emitter<MostPopularState> emit, {
    Period? period,
  }) async {
    emit(state.copyWith(pageState: const PageState.loading()));
    final result =
        await _facade.getMostPopularArticles(MostPopularParams(period: period));
    result.when(success: (data) {
      emit(state.copyWith(pageState: PageState.loaded(data: data)));
    }, failure: (message) {
      emit(state.copyWith(pageState: PageState.error(error: message)));
    });
  }
}

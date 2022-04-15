part of 'most_popular_bloc.dart';

@immutable
class MostPopularState extends Equatable {
  final PageState<List<Article>> pageState;
  final Period period;

  const MostPopularState({required this.pageState, required this.period});

  factory MostPopularState.init() =>
      const MostPopularState(pageState: PageState.init(), period: Period.daily);

  factory MostPopularState.loading({required Period period}) =>
      const MostPopularState(
          pageState: PageState.loading(), period: Period.daily);

  factory MostPopularState.loaded({
    required Period period,
    required PageState<List<Article>> pageState,
  }) =>
      MostPopularState(pageState: pageState, period: Period.daily);

  MostPopularState copyWith({
    PageState<List<Article>>? pageState,
    Period? period,
  }) {
    return MostPopularState(
      pageState: pageState ?? this.pageState,
      period: period ?? this.period,
    );
  }

  @override
  List<Object?> get props => [pageState, period];
}

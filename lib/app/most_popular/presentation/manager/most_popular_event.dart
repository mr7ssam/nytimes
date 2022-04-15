part of 'most_popular_bloc.dart';

@immutable
abstract class MostPopularEvent {}

class MostPopularStarted extends MostPopularEvent {}

class PeriodChanged extends MostPopularEvent {
  final Period period;

  PeriodChanged(this.period);
}

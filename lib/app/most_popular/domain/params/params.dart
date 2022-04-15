import 'package:core/core.dart';

enum Period {
  daily,
  weekly,
  monthly,
}

extension PeriodExtension on Period {
  int get value {
    switch (this) {
      case Period.daily:
        return 1;
      case Period.weekly:
        return 7;
      case Period.monthly:
        return 30;
    }
  }
}

class MostPopularParams extends Params {
  final String section;
  final Period? period;

  MostPopularParams({
    this.section = 'all-sections',
    this.period,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'section': section,
      'period': (period ?? Period.daily).value,
    };
  }
}

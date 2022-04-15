import 'package:get_it/get_it.dart';
import 'features.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  general();
  mostPopular();
}

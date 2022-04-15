import 'package:bootstrap/bootstrap.dart';
import 'package:flutter/services.dart';
import 'package:nytimes/locator/locator.dart';

import 'app.dart';

void main() async {
  await setupLocator();

  bootstrap(
    () async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return const App();
    },
  );
}

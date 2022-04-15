import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:nytimes/app/router/router.dart';
import 'package:nytimes/providers.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      builder: (context) => ScreenUtilInit(
        builder: (context) {
          final appRouter = AppRouter.of(context);
          return MaterialApp.router(
            routeInformationParser: appRouter.goRouter.routeInformationParser,
            routerDelegate: appRouter.goRouter.routerDelegate,
            title: 'NyTimes',
            theme: lightTheme,
          );
        },
      ),
    );
  }
}

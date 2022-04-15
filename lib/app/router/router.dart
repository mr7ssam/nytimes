import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nytimes/app/router/routes.dart';
import 'package:provider/provider.dart';

class AppRouter {
  AppRouter({
    required this.context,
  }) {
    goRouter = GoRouter(
      routes: _routes,
      initialLocation: MostPopularScreen.path,
    );
  }

  final BuildContext context;

  late final GoRouter goRouter;

  late final _routes = [
    GoRoute(
        path: MostPopularScreen.path,
        name: MostPopularScreen.name,
        pageBuilder: MostPopularScreen.pageBuilder,
        routes: [
          GoRoute(
            path: ArticleDetails.path,
            name: ArticleDetails.name,
            pageBuilder: ArticleDetails.pageBuilder,
          ),
        ]),
  ];

  static AppRouter of(BuildContext context) {
    return Provider.of<AppRouter>(context, listen: false);
  }
}

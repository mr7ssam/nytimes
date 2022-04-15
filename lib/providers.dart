import 'package:flutter/material.dart';
import 'package:nytimes/app/router/router.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    Key? key,
    required this.builder,
  }) : super(key: key);
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppRouter>(create: (_) => AppRouter(context: context)),
      ],
      builder: (context, child) => builder(context),
    );
  }
}

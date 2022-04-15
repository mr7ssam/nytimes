import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../widgets/article_sliver_app_bar.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({Key? key, required this.article}) : super(key: key);
  final Article article;
  static const path = 'article-details';
  static const name = 'article-details-screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
        key: state.pageKey,
        child: ArticleDetails(
          article: state.extra as Article,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final url = article.image440?.url;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ArticleSliverAppBar(url: url),
            SliverPadding(
              padding: PEdgeInsets.listView,
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: [
                        YouText.bodySmall(article.section),
                        const Spacer(),
                        YouText.bodySmall(DateFormat.yMMMMEEEEd()
                            .format(article.publishedDate)),
                      ],
                    ),
                    Row(
                      children: [
                        YouText.titleMedium(article.source),
                        const Spacer(),
                        YouText.bodySmall(
                            'updated: ${format(article.updated)}'),
                      ],
                    ),
                    Space.vM1,
                    YouText.headlineSmall(article.title),
                    Space.vM3,
                    YouText.bodyMedium(article.articleAbstract,
                        textAlign: TextAlign.justify),
                    Space.vM3,
                    YouText.bodySmall(article.byline),
                    Space.vL1,
                    ElevatedButton.icon(
                      onPressed: _onLinkPressed,
                      icon: const Icon(Icons.link),
                      label: const Text(
                        'Go to article',
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onLinkPressed() {
    url_launcher.launch(article.url);
  }
}

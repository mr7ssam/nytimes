import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:nytimes/app/most_popular/domain/params/params.dart';
import 'package:nytimes/app/most_popular/presentation/manager/most_popular_bloc.dart';
import 'package:nytimes/app/most_popular/presentation/pages/article_details_screen.dart';
import 'package:nytimes/locator/locator.dart';

import '../widgets/article_list_tile.dart';

class MostPopularScreen extends StatelessWidget {
  const MostPopularScreen({Key? key}) : super(key: key);

  static const path = '/most-popular';
  static const name = 'most-popular-screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<MostPopularBloc>(
        create: (context) =>
            MostPopularBloc(locator())..add(MostPopularStarted()),
        child: const MostPopularScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _retry(context),
            icon: const Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Most Popular - NyTimes',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: BlocSelector<MostPopularBloc, MostPopularState, Period>(
              selector: (state) => state.period,
              builder: (_, period) => Padding(
                padding: PEdgeInsets.horizontal,
                child: CustomChipSelect<Period>(
                  onChanged: (period) {
                    context.read<MostPopularBloc>().add(PeriodChanged(period));
                  },
                  selected: period,
                  items: const [
                    Period.daily,
                    Period.weekly,
                    Period.monthly,
                  ],
                  itemAsString: (v) => v.name.toUpperCase(),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MostPopularBloc, MostPopularState>(
              builder: (context, state) {
                return PageStateBuilder<List<Article>>(
                  state: state.pageState,
                  error: (error) => FetchErrorWidget(
                      onRetry: () => _retry(context), error: error),
                  success: (data) => AnimationLimiter(
                    child: ListView.separated(
                      padding: PEdgeInsets.listView,
                      separatorBuilder: (context, index) => Space.vS3,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final article = data[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ArticleListTile(
                                article: article,
                                onTap: () {
                                  _onArticlePressed(context, article);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onArticlePressed(BuildContext context, Article article) {
    context.pushNamed(ArticleDetails.name, extra: article);
  }

  void _retry(BuildContext context) {
    context.read<MostPopularBloc>().retry();
  }
}

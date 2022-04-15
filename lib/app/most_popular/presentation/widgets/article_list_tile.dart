import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:nytimes/app/most_popular/domain/entities/article.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleListTile extends StatelessWidget {
  const ArticleListTile({Key? key, required this.article, this.onTap})
      : super(key: key);
  final Article article;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var thumb = article.thumb?.url;
    return SizedBox(
      height: 100.h,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300, width: 0.5.r),
          borderRadius: BorderRadius.circular(PRadius.card.r),
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: thumb != null
                    ? AppNetworkImage(
                        url: thumb,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        color: Colors.grey,
                        child: Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                            size: 50.r,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: RPadding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YouText.labelMedium(article.title,
                          maxLines: 1, textOverflow: TextOverflow.ellipsis),
                      YouText.bodySmall(article.byline,
                          maxLines: 1, textOverflow: TextOverflow.ellipsis),
                      Row(
                        children: [
                          YouText.bodySmall(article.section),
                          const Spacer(),
                          YouText.bodySmall(
                              timeago.format(article.publishedDate)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

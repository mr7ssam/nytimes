import 'package:design/design.dart';
import 'package:flutter/material.dart';

class ArticleSliverAppBar extends StatelessWidget {
  const ArticleSliverAppBar({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const Card(
        child: BackButton(color: Colors.white),
        shape: CircleBorder(),
        color: Colors.black26,
      ),
      expandedHeight: 200.h,
      flexibleSpace: FlexibleSpaceBar(
        background: url != null
            ? ExtendedImageSlidePage(
                child: AppNetworkImage(
                  url: url!,
                ),
              )
            : Icon(
                Icons.image,
                size: 100.h,
                color: Colors.black26,
              ),
      ),
    );
  }
}

import 'package:design/src/widgets/text.dart';
import 'package:flutter/material.dart';

class FetchErrorWidget extends StatelessWidget {
  const FetchErrorWidget({
    Key? key,
    required this.onRetry,
    required this.error,
  }) : super(key: key);

  final Function() onRetry;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        YouText.bodySmall(error),
        IconButton(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}

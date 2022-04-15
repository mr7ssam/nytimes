import 'package:flutter/foundation.dart';
import 'package:network/p_http_client.dart';
import 'package:nytimes/common/const.dart';
import 'package:nytimes/locator/locator.dart';

void general() {
  locator.registerSingleton<Dio>(
    _dioClient(),
  );
}

DioClient _dioClient() {
  return DioClient(
    kBaseURL,
    interceptors: [
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({'api-key': kAPIKey});
          handler.next(options);
        },
      ),
      if (!kReleaseMode)
        LogInterceptor(
          request: true,
          responseBody: true,
          error: true,
        ),
    ],
  );
}

import 'dart:async';
import 'dart:developer';

import 'package:network/api_result.dart';

import '../exceptions.dart';

Future<ApiResult<T>> toApiResult<T>(FutureOr<T> Function() call) async {
  try {
    return ApiResult.success(data: await call());
  } on AppNetworkResponseException catch (e) {
    return ApiResult.failure(message: e.data);
  } on AppNetworkException catch (e) {
    return ApiResult.failure(message: e.message);
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    return ApiResult.failure(
      message: AppException.unknown(exception: e).message,
    );
  }
}

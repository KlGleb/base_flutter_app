import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:reviewmagic_flutter/features/error/api_failure.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var data = response.data;
    if (data is String) {
      data = json.decode(data);
    }

    if (response.statusCode == 200) {
      response.data = data;
      handler.next(response);
    } else {
      throw ApiFailure.fromData(data: data, requestOptions: response.requestOptions);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(ApiFailure.fromDioException(err), handler);
  }
}

import 'package:dio/dio.dart';
import 'package:reviewmagic_flutter/features/error/failure_codes.dart';
import 'package:reviewmagic_flutter/features/error/failure_response.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';

class ApiFailure extends DioException implements Failure {
  ApiFailure({required super.requestOptions, required FailureCode code}) : _code = code;

  ApiFailure.fromDioException(DioException e)
      : _code = FailureCode.unknown,
        super(
          requestOptions: e.requestOptions,
          response: e.response,
          type: e.type,
          error: e.error,
          stackTrace: e.stackTrace,
          message: e.message,
        ) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      _code = FailureCode.connectionError;
    } else {
      _getCodeFromData(e.response?.data);
    }
  }

  ApiFailure.fromData({Map<String, dynamic>? data, required super.requestOptions}) : _code = FailureCode.unknown {
    _getCodeFromData(data);
  }

  FailureCode _code;

  @override
  FailureCode get code => _code;

  void _getCodeFromData(Map<String, dynamic>? data) {
    if (data != null && data.isNotEmpty) {
      final resp = FailureResponse.fromJson(data);
      _code = resp.code;
    }
  }
}

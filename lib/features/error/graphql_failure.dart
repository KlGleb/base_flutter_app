import 'package:graphql/client.dart';
import 'package:reviewmagic_flutter/features/error/failure_codes.dart';
import 'package:reviewmagic_flutter/features/error/failure_response.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';

class GraphQlFailure implements Failure, Exception {
  GraphQlFailure({required FailureCode code}) : _code = code;

  GraphQlFailure.fromGraphQlError(GraphQLError e) : _code = FailureCode.unknown {
    _getCodeFromData(e.extensions);
  }

  GraphQlFailure.unknown() : _code = FailureCode.unknown;

  GraphQlFailure.fromData({Map<String, dynamic>? data}) : _code = FailureCode.unknown {
    _getCodeFromData(data);
  }

  FailureCode _code;

  @override
  FailureCode get code => _code;

  void _getCodeFromData(Map<String, dynamic>? data) {
    if (data != null && data.isNotEmpty && data['code'] != null) {
      final resp = FailureResponse.fromJson(data);
      _code = resp.code;
    }
  }
}

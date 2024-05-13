import 'dart:io';

import 'package:graphql/client.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/error/failure_codes.dart';
import 'package:reviewmagic_flutter/features/error/graphql_failure.dart';

mixin DataSource {
  Future<T> executeQuery<T, V>({
    required Future queryBuilder,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    if (!await _hasConnection()) {
      throw GraphQlFailure(code: FailureCode.connectionError);
    }

    try {
      final QueryResult result = await queryBuilder;

      if (result.data == null) {
        final GraphQLError? error = result.exception?.graphqlErrors.firstOrNull;
        if (error != null) {
          throw GraphQlFailure.fromGraphQlError(error);
        } else {
          throw GraphQlFailure.unknown();
        }
      }

      return fromJson(result.data!);
    } on GraphQlFailure {
      rethrow;
    } on Exception {
      throw GraphQlFailure.unknown();
    }
  }

  Future<bool> _hasConnection() async {
    var hasConnection = false;
    final d = DateTime.now();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    logger.f('Connection check ${DateTime.now().difference(d).inMilliseconds} mills');

    return hasConnection;
  }
}

import 'package:reviewmagic_flutter/features/error/failure_codes.dart';

export 'api_failure.dart';

abstract class Failure implements Exception {
  FailureCode get code;
}

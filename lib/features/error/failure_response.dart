import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reviewmagic_flutter/features/error/failure_codes.dart';

part 'failure_response.freezed.dart';

part 'failure_response.g.dart';

@freezed
class FailureResponse with _$FailureResponse {
  const factory FailureResponse({
    required FailureCode code,
  }) = _FailureResponse;

  factory FailureResponse.fromJson(Map<String, dynamic> json) => _$FailureResponseFromJson(json);
}

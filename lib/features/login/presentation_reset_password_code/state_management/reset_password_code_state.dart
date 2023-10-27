import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_code_state.freezed.dart';

@freezed
class ResetPasswordCodeState with _$ResetPasswordCodeState {
  const factory ResetPasswordCodeState({
    required String code,
    String? password,
    String? repeatPassword,
    @Default(false) bool inProgress,
    String? errorMessage,
  }) = _ResetPasswordCodeState;
}

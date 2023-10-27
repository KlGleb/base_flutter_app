import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    String? email,
    @Default(false) bool isBusy,
    String? errorMessage,
    @Default(false) bool success,
  }) = _ResetPasswordState;
}

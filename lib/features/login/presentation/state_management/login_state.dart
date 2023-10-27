import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool inProgress,
    String? errorMessage,
    String? userName,
    String? password,
  }) = _LoginState;
}

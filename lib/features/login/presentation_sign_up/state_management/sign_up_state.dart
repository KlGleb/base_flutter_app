import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(false) bool inProgress,
    String? errorMessage,
    String? userName,
    String? password,
    String? repeatPassword,
  }) = _SignUpState;
}

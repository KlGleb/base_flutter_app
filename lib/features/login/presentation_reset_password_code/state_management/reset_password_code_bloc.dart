import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/features/error/failure_codes.dart';
import 'package:reviewmagic_flutter/features/error/failure_user_message.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';
import 'package:reviewmagic_flutter/features/login/domain/repositories/auth_repository.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/state_management/reset_password_code_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/state_management/reset_password_code_state.dart';

class ResetPasswordCodeBloc extends Bloc<ResetPasswordCodeEvent, ResetPasswordCodeState> {
  ResetPasswordCodeBloc(this._repository) : super(const ResetPasswordCodeState()) {
    on<ResetPassword>(_onResetPasswordCode);
    on<SavePassword>(_onSavePassword);
    on<SaveRepeatPassword>(_onSaveRepeatPassword);
    on<SaveCode>(_onSaveCode);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  final AuthRepository _repository;

  Future _onResetPasswordCode(ResetPassword event, Emitter<ResetPasswordCodeState> emit) async {
    emit(state.copyWith(inProgress: true, errorMessage: null));

    try {
      await _repository.sendCode(state.code!, state.password!);
    } on Failure catch (e) {
      if (e.code == FailureCode.wrongCode) {
        emit(state.copyWith(errorMessage: null, inProgress: false, wrongCode: true));
      } else {
        emit(state.copyWith(errorMessage: e.userMsg, inProgress: false, wrongCode: false));
      }
    }
  }

  void _onSavePassword(SavePassword event, Emitter<ResetPasswordCodeState> emit) =>
      emit(state.copyWith(password: event.password));

  void _onSaveRepeatPassword(SaveRepeatPassword event, Emitter<ResetPasswordCodeState> emit) =>
      emit(state.copyWith(repeatPassword: event.password));

  void _onSaveCode(SaveCode event, Emitter<ResetPasswordCodeState> emit) => emit(state.copyWith(code: event.code));

  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<ResetPasswordCodeState> emit) =>
      emit(state.copyWith(showPassword: !state.showPassword));
}

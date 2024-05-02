import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/error/failure_user_message.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';
import 'package:reviewmagic_flutter/features/login/domain/repositories/auth_repository.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password/state_management/reset_password_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password/state_management/reset_password_state.dart';

@Injectable()
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc(this._repository) : super(const ResetPasswordState()) {
    on<ResetPassword>(_onResetPassword);
    on<SaveEmail>(_onSaveEmail);
  }

  final AuthRepository _repository;

  Future _onResetPassword(ResetPassword event, Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(isBusy: true, errorMessage: null, success: false));

    try {
      await _repository.resetPassword(state.email!);
      emit(state.copyWith(errorMessage: null, success: true));
    } on Failure catch (e) {
      emit(state.copyWith(errorMessage: e.userMsg, isBusy: false));
    }
  }

  void _onSaveEmail(SaveEmail event, Emitter<ResetPasswordState> emit) => emit(state.copyWith(email: event.email));
}

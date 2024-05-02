import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/error/failure_user_message.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';
import 'package:reviewmagic_flutter/features/login/domain/repositories/auth_repository.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/state_management/sign_up_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/state_management/sign_up_state.dart';

@Injectable()
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._repository) : super(const SignUpState()) {
    on<SignUp>(_onSignUp);
    on<SaveUserName>(_onSaveUserName);
    on<SavePassword>(_onSavePassword);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  final AuthRepository _repository;

  Future _onSignUp(SignUp event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(inProgress: true, errorMessage: null));

    try {
      await _repository.signUp(state.userName!, state.password!);
    } on Failure catch (e) {
      emit(state.copyWith(errorMessage: e.userMsg, inProgress: false));
    }
  }

  void _onSaveUserName(SaveUserName event, Emitter<SignUpState> emit) => emit(state.copyWith(userName: event.userName));

  void _onSavePassword(SavePassword event, Emitter<SignUpState> emit) => emit(state.copyWith(password: event.password));

  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<SignUpState> emit) =>
      emit(state.copyWith(showPasswords: !state.showPasswords));
}

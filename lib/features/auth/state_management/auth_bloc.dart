import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/login/domain/repositories/auth_repository.dart';

@LazySingleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  late StreamSubscription _sub;

  AuthBloc(this._repository) : super(AuthState.init) {
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<Init>(_onInit);
    on<Logout>(_onLogout);

    _sub = _repository.authState.listen((event) {
      switch (event) {
        case AuthState.loggedIn:
          add(LoggedIn());
        case AuthState.loggedOut:
          add(LoggedOut());
        case AuthState.init:
        // add(Init());
      }
    });
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) => emit(AuthState.loggedIn);

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) => emit(AuthState.loggedOut);

  void _onInit(Init event, Emitter<AuthState> emit) => emit(AuthState.init);

  void _onLogout(Logout event, Emitter<AuthState> emit) => _repository.logOut();
}

sealed class AuthEvent {}

class Logout extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}

class Init extends AuthEvent {}

enum AuthState { loggedIn, loggedOut, init }

import 'package:reviewmagic_flutter/features/auth/state_management/auth_bloc.dart';

abstract class AuthRepository {
  Future login(String email, String password);

  Future signUp(String email, String password);

  Future resetPassword(String email);

  Future sendCode(String code, String password);

  Future logOut();

  Stream<AuthState> get authState;
}

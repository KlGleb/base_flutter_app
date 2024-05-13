import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/core/data/credentials_storage.dart';
import 'package:reviewmagic_flutter/features/auth/state_management/auth_bloc.dart';
import 'package:reviewmagic_flutter/features/login/data/ds/auth.graphql.dart';
import 'package:reviewmagic_flutter/features/login/data/ds/login_ds.dart';
import 'package:reviewmagic_flutter/features/login/domain/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._dataSource, this._storage) {
    _init();
  }

  final CredentialsStorage _storage;

  final LoginDataSource _dataSource;

  final BehaviorSubject<AuthState> _subject = BehaviorSubject()..add(AuthState.init);

  @override
  Future login(String email, String password) async {
    final res = await _dataSource.login(Variables$Query$LogIn(email: email, password: password));
    await _onLoggedIn(res.auth);
  }

  @override
  Future signUp(String email, String password) async {
    final res = await _dataSource.register(Variables$Query$SignUp(email: email, password: password));
    await _onLoggedIn(res.signUp);
  }

  @override
  Future logOut() => _onLoggedOut();

  @override
  Stream<AuthState> get authState => _subject.distinct();

  @override
  Future resetPassword(String email) =>
      _dataSource.sendCodeToEmail(Variables$Query$SendResetPasswordCode(email: email));

  @override
  Future sendCode(String email, String code, String password) async {
    final res = await _dataSource
        .resetPasswordByCode(Variables$Mutation$ResetPassword(email: email, code: code, newPassword: password));
    await _onLoggedIn(res.auth);
  }

  Future _onLoggedIn(String token) async {
    await _storage.putToken(token);
    _subject.add(AuthState.loggedIn);
  }

  Future _onLoggedOut() async {
    await _storage.delete();
    _subject.add(AuthState.loggedOut);
  }

  void _init() async {
    final token = await _storage.token;
    if (token == null) {
      _subject.add(AuthState.loggedOut);
    } else {
      _subject.add(AuthState.loggedIn);
    }
  }
}

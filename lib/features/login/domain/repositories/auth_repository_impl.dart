import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/core/data/credentials_storage.dart';
import 'package:reviewmagic_flutter/features/auth/state_management/auth_bloc.dart';
import 'package:reviewmagic_flutter/features/login/data/ds/login_ds.dart';
import 'package:reviewmagic_flutter/features/login/data/dtos/login_dto.dart';
import 'package:reviewmagic_flutter/features/login/data/entities/reset_password_entity.dart';
import 'package:reviewmagic_flutter/features/login/data/repositories/login_repository.dart';
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
    final res = await _dataSource.login(LoginDto(email: email, password: password));
    await _onLoggedIn(res.token);
  }

  @override
  Future signUp(String email, String password) async {
    final res = await _dataSource.register(LoginDto(email: email, password: password));
    await _onLoggedIn(res.token);
  }

  @override
  Future logOut() => _onLoggedOut();

  @override
  Stream<AuthState> get authState => _subject.distinct();

  @override
  Future resetPassword(String email) => _dataSource.sendCodeToEmail(email);

  @override
  Future sendCode(String code, String password) async {
    final res = await _dataSource.resetPasswordByCode(ResetPasswordEntity(code: code, newPassword: password));
    await _onLoggedIn(res.token);
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

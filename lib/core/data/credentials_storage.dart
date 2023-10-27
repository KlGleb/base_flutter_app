import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class CredentialsStorage {
  Future putToken(String token);

  Future<String?> get token;

  Future delete();
}

@Singleton(as: CredentialsStorage)
class CredentialsStorageImpl implements CredentialsStorage {
  static const _tokenKey = 'token';

  String? _token;
  final FlutterSecureStorage _storage;

  CredentialsStorageImpl(this._storage);

  @override
  Future putToken(String token) async {
    _token = _token;
    await _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> get token async {
    if (_token != null) return _token!;
    return await _storage.read(key: _tokenKey);
  }

  @override
  Future delete() async {
    _token = null;
    await _storage.delete(key: _tokenKey);
  }
}

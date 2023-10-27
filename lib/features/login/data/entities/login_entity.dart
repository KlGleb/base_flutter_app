import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reviewmagic_flutter/features/login/domain/login_model.dart';

part 'login_entity.freezed.dart';

part 'login_entity.g.dart';

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    required String token,
  }) = _LoginEntity;

  factory LoginEntity.fromJson(Map<String, dynamic> json) => _$LoginEntityFromJson(json);
}

extension LoginEntityExt on LoginEntity {
  LoginModel get model => LoginModel(token: token);
}

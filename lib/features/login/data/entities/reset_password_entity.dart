import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_entity.freezed.dart';

part 'reset_password_entity.g.dart';

@freezed
class ResetPasswordEntity with _$ResetPasswordEntity {
  const factory ResetPasswordEntity({
    required String code,
    required String newPassword,
  }) = _ResetPasswordEntity;

  factory ResetPasswordEntity.fromJson(Map<String, dynamic> json) => _$ResetPasswordEntityFromJson(json);
}

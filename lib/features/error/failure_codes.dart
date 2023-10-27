import 'package:json_annotation/json_annotation.dart';

enum FailureCode {
  @JsonValue('unknown')
  unknown,
  @JsonValue('wrong_credentials')
  wrongCredentials,
  @JsonValue('email_is_already_registered')
  emailIsAlreadyRegistered,
  @JsonValue('user_not_found')
  userNotFound,
  @JsonValue('code_not_exists')
  codeNotExists,
  @JsonValue('email_not_registered')
  emailNotRegistered,
  @JsonValue('no_permission')
  noPermission,
  @JsonValue('wrong_token')
  wrongToken,
  @JsonValue('wrong_password')
  wrongPassword,
  @JsonValue('no_access_token')
  noAccessToken,
  @JsonValue('wrong_code')
  wrongCode,
  @JsonValue('code_expired')
  codeExpired,
  @JsonValue('too_many_email_sent')
  tooManyEmailSent,
  @JsonValue('too_many_tries')
  tooManyTries,
  connectionError,
}

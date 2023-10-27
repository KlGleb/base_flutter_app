import 'package:easy_localization/easy_localization.dart';
import 'package:reviewmagic_flutter/features/error/failure_codes.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';

extension FailureUserMessage on Failure {
  String get userMsg {
    final String localeKey;
    switch (code) {
      case FailureCode.wrongCredentials:
        localeKey = LocaleKeys.errors_auth_wrongCredentials;
      case FailureCode.emailIsAlreadyRegistered:
        localeKey = LocaleKeys.errors_auth_emailAlreadySignedUp;
      case FailureCode.connectionError:
        localeKey = LocaleKeys.errors_general_connection;
      case FailureCode.emailNotRegistered:
        localeKey = LocaleKeys.errors_auth_emailNotFound;
      default:
        localeKey = LocaleKeys.errors_general_unknown;
    }

    return localeKey.tr();
  }
}

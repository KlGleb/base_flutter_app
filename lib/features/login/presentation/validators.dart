import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';

FormFieldValidator<String> emailValidator(BuildContext context) => (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.validation_emptyEmail.tr();
      }

      if (!EmailValidator.validate(value)) {
        return LocaleKeys.validation_invalidEmail.tr();
      }

      return null;
    };

FormFieldValidator<String> passwordValidator(BuildContext context) => (value) {
      if (value == null || value.isEmpty) {
        return LocaleKeys.validation_emptyPassword.tr();
      }
      return null;
    };

FormFieldValidator<String> codeValidator(BuildContext context) => (value) {
      if (value == null || value.isEmpty) {
        return 'Пожалуйста, введите код из письма';
      }
      return null;
    };

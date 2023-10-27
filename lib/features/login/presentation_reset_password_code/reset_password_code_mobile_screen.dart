import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password/reset_password_form.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/reset_password_code_form.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';

class ResetPasswordMobileScreen extends StatelessWidget {
  const ResetPasswordMobileScreen({Key? key, this.code}) : super(key: key);
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.signUp_title.tr())),
      body: SingleChildScrollView(
        child: code == null ? ResetPasswordForm() : ResetPasswordCodeForm(code: code!),
      ),
    );
  }
}

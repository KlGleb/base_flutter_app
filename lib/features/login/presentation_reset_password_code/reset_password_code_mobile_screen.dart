import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password/reset_password_form.dart';

class ResetPasswordMobileScreen extends StatelessWidget {
  const ResetPasswordMobileScreen({Key? key, this.code}) : super(key: key);
  final String? code;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: ResetPasswordForm(),
          ),
        ),
      );
}

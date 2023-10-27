import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/login/presentation/login_form.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.login_title.tr())),
      body: SingleChildScrollView(
        child: LoginForm(),
      ),
    );
  }
}

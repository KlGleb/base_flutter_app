import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/sign_up_form.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';

class SignUpMobileScreen extends StatelessWidget {
  const SignUpMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.signUp_title.tr())),
      body: SingleChildScrollView(
        child: SignUpForm(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/sign_up_form.dart';

class SignUpMobileScreen extends StatelessWidget {
  const SignUpMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SignUpForm(),
        ),
      ),
    );
  }
}

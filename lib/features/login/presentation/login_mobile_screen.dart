import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/login/presentation/login_form.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }
}

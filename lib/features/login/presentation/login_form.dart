import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/login/presentation/error_field.dart';
import 'package:reviewmagic_flutter/features/login/presentation/state_management/login_bloc.dart';
import 'package:reviewmagic_flutter/features/login/presentation/state_management/login_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation/state_management/login_state.dart';
import 'package:reviewmagic_flutter/features/login/presentation/validators.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';
import 'package:routemaster/routemaster.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(border: OutlineInputBorder());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider<LoginBloc>(
        create: (context) => getIt(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final bloc = context.read<LoginBloc>();
            final captionStyle = Theme.of(context).textTheme.bodyMedium;
            final linksStyle = captionStyle?.copyWith(color: Theme.of(context).colorScheme.primary);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      initialValue: kDebugMode ? 'info@gleb.at' : null,
                      decoration: decoration.copyWith(labelText: LocaleKeys.login_emailLabel.tr()),
                      onSaved: (newValue) => bloc.add(SaveUserName(newValue!)),
                      validator: emailValidator(context),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: kDebugMode ? '123' : null,
                      decoration: decoration.copyWith(labelText: LocaleKeys.login_passwordLabel.tr()),
                      obscureText: true,
                      validator: passwordValidator(context),
                      onSaved: (newValue) => bloc.add(SavePassword(newValue!)),
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                    ),
                    const SizedBox(height: 16.0),
                    ErrorField(message: state.errorMessage),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: state.inProgress
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                _formKey.currentState!.save();
                                bloc.add(Login());
                              }
                            },
                      child: Text(LocaleKeys.login_loginButton.tr()),
                    ),
                    const SizedBox(height: 32),
                    _SignUpLabel(captionStyle: captionStyle, linksStyle: linksStyle),
                    _ResetPasswordLabel(captionStyle: captionStyle, linksStyle: linksStyle),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ResetPasswordLabel extends StatelessWidget {
  const _ResetPasswordLabel({
    Key? key,
    required this.captionStyle,
    required this.linksStyle,
  }) : super(key: key);

  final TextStyle? captionStyle;
  final TextStyle? linksStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${LocaleKeys.login_forgotPasswordLabel.tr()} ',
            style: captionStyle,
          ),
          TextSpan(
            text: LocaleKeys.login_resetPasswordButton.tr(),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Routemaster.of(context).push('/resetPassword');
              },
            style: linksStyle,
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
        ],
      ),
    );
  }
}

class _SignUpLabel extends StatelessWidget {
  const _SignUpLabel({
    Key? key,
    required this.captionStyle,
    required this.linksStyle,
  }) : super(key: key);

  final TextStyle? captionStyle;
  final TextStyle? linksStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${LocaleKeys.login_signUpLabel.tr()} ',
            style: captionStyle,
          ),
          TextSpan(
            text: LocaleKeys.login_signUpButton.tr(),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Routemaster.of(context).replace('/signup');
              },
            style: linksStyle,
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
        ],
      ),
    );
  }
}

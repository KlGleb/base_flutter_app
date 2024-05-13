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
            final captionStyle = Theme.of(context).textTheme.labelLarge;
            final linksStyle = captionStyle?.copyWith(color: Theme.of(context).colorScheme.primary);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.login_title.tr(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 44),
                    TextFormField(
                      initialValue: kDebugMode ? 'info@gleb.at' : null,
                      decoration: decoration.copyWith(labelText: LocaleKeys.login_emailLabel.tr()),
                      onSaved: (newValue) => bloc.add(SaveUserName(newValue!)),
                      validator: emailValidator(context),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email, AutofillHints.username],
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: kDebugMode ? '345' : null,
                      decoration: decoration.copyWith(
                        labelText: LocaleKeys.login_passwordLabel.tr(),
                        suffixIcon: IconButton(
                          onPressed: () => bloc.add(TogglePasswordVisibility()),
                          icon: Icon(state.showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        ),
                      ),
                      obscureText: !state.showPassword,
                      validator: passwordValidator(context),
                      onSaved: (newValue) => bloc.add(SavePassword(newValue!)),
                      textInputAction: TextInputAction.send,
                      autofillHints: const [AutofillHints.password],
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (value) => _submitForm(context),
                    ),
                    const SizedBox(height: 8.0),
                    ErrorField(message: state.errorMessage),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: state.inProgress ? null : () => _submitForm(context),
                      child: Text(LocaleKeys.login_loginButton.tr()),
                    ),
                    const SizedBox(height: 32),
                    SignUpLabel(captionStyle: captionStyle, linksStyle: linksStyle),
                    const SizedBox(height: 16),
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

  void _submitForm(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      bloc.add(Login());
    }
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

@visibleForTesting
class SignUpLabel extends StatelessWidget {
  static const findKey = Key('_SignUpLabel');

  const SignUpLabel({
    Key? key,
    required this.captionStyle,
    required this.linksStyle,
  }) : super(key: key);

  final TextStyle? captionStyle;
  final TextStyle? linksStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: findKey,
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

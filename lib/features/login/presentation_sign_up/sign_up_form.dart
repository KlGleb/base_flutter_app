import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/login/presentation/error_field.dart';
import 'package:reviewmagic_flutter/features/login/presentation/validators.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/state_management/sign_up_bloc.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/state_management/sign_up_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/state_management/sign_up_state.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';
import 'package:routemaster/routemaster.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: kDebugMode ? '123' : null);
  final _repeatPasswordController = TextEditingController(text: kDebugMode ? '123' : null);

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(border: OutlineInputBorder());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider<SignUpBloc>(
        create: (context) => getIt(),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            final bloc = context.read<SignUpBloc>();
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
                      controller: _passwordController,
                      decoration: decoration.copyWith(labelText: LocaleKeys.login_passwordLabel.tr()),
                      obscureText: true,
                      validator: _passwordValidator(context),
                      onSaved: (newValue) => bloc.add(SavePassword(newValue!)),
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _repeatPasswordController,
                      decoration: decoration.copyWith(labelText: LocaleKeys.signUp_repeatPasswordLabel.tr()),
                      obscureText: true,
                      validator: _passwordValidator(context),
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
                                bloc.add(SignUp());
                              }
                            },
                      child: Text(LocaleKeys.signUp_signUpButton.tr()),
                    ),
                    const SizedBox(height: 32),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${LocaleKeys.signUp_loginButtonLabel.tr()} ',
                            style: captionStyle,
                          ),
                          TextSpan(
                            text: LocaleKeys.signUp_loginButton.tr(),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Routemaster.of(context).replace('/login');
                              },
                            style: linksStyle,
                            mouseCursor: MaterialStateMouseCursor.clickable,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FormFieldValidator _passwordValidator(BuildContext context) => (value) {
        final v = passwordValidator(context)(value);
        if (v != null) return v;
        if (_passwordController.text != _repeatPasswordController.text) {
          return LocaleKeys.validation_passwordsAreNotSame.tr();
        }
        return null;
      };
}

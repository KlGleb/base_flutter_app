import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/login/presentation/error_field.dart';
import 'package:reviewmagic_flutter/features/login/presentation/validators.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/state_management/reset_password_code_bloc.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/state_management/reset_password_code_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/state_management/reset_password_code_state.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';

class ResetPasswordCodeForm extends StatelessWidget {
  ResetPasswordCodeForm({Key? key, required this.code}) : super(key: key);
  final String code;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: kDebugMode ? '123' : null);
  final _repeatPasswordController = TextEditingController(text: kDebugMode ? '123' : null);

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(border: OutlineInputBorder());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider<ResetPasswordCodeBloc>(
        create: (context) => ResetPasswordCodeBloc(getIt(), code),
        child: BlocBuilder<ResetPasswordCodeBloc, ResetPasswordCodeState>(
          builder: (context, state) {
            final bloc = context.read<ResetPasswordCodeBloc>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      decoration: decoration.copyWith(labelText: LocaleKeys.resetPasswordCode_passwordLabel.tr()),
                      onSaved: (newValue) => bloc.add(SavePassword(newValue!)),
                      validator: _passwordValidator(context),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.password],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _repeatPasswordController,
                      decoration: decoration.copyWith(labelText: LocaleKeys.resetPasswordCode_repeatPasswordLabel.tr()),
                      onSaved: (newValue) => bloc.add(SaveRepeatPassword(newValue!)),
                      validator: _passwordValidator(context),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.password],
                    ),
                    ErrorField(message: state.errorMessage),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: state.inProgress
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                _formKey.currentState!.save();
                                bloc.add(ResetPassword());
                              }
                            },
                      child: Text(LocaleKeys.resetPasswordCode_resetPasswordButton.tr()),
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

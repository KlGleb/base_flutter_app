import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/login/presentation/error_field.dart';
import 'package:reviewmagic_flutter/features/login/presentation/validators.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password/state_management/reset_password_bloc.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password/state_management/reset_password_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password/state_management/reset_password_state.dart';
import 'package:reviewmagic_flutter/generated/lang.dart';
import 'package:routemaster/routemaster.dart';

class ResetPasswordForm extends StatelessWidget {
  ResetPasswordForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(border: OutlineInputBorder());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider<ResetPasswordBloc>(
        create: (context) => getIt(),
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          builder: (context, state) {
            final bloc = context.read<ResetPasswordBloc>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.success) ...[
                      Text(LocaleKeys.resetPassword_sendLinkSuccess.tr()),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () => Routemaster.of(context).replace('/'),
                        child: Text(LocaleKeys.resetPassword_backButton.tr()),
                      ),
                    ] else ...[
                      TextFormField(
                        initialValue: kDebugMode ? 'info@gleb.at' : null,
                        decoration: decoration.copyWith(labelText: LocaleKeys.resetPassword_emailFieldLabel.tr()),
                        onSaved: (newValue) => bloc.add(SaveEmail(newValue!)),
                        validator: emailValidator(context),
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                      ),
                      const SizedBox(height: 16.0),
                      ErrorField(message: state.errorMessage),
                      const SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: state.isBusy
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  _formKey.currentState!.save();
                                  bloc.add(ResetPassword());
                                }
                              },
                        child: Text(LocaleKeys.resetPassword_resetPasswordButton.tr()),
                      ),
                    ],
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

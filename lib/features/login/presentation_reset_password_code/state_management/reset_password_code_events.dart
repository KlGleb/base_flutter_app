sealed class ResetPasswordCodeEvent {}

class ResetPassword extends ResetPasswordCodeEvent {}

class SavePassword extends ResetPasswordCodeEvent {
  final String password;

  SavePassword(this.password);
}

class SaveRepeatPassword extends ResetPasswordCodeEvent {
  final String password;

  SaveRepeatPassword(this.password);
}

class SaveCode extends ResetPasswordCodeEvent {
  final String code;

  SaveCode(this.code);
}

class TogglePasswordVisibility extends ResetPasswordCodeEvent {}
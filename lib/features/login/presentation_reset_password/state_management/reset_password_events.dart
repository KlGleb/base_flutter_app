sealed class ResetPasswordEvent {}

class SaveEmail extends ResetPasswordEvent {
  final String email;

  SaveEmail(this.email);
}

class ResetPassword extends ResetPasswordEvent {}

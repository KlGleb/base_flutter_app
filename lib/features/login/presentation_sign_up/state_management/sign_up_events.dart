sealed class SignUpEvent {}

class SignUp extends SignUpEvent {}

class Register extends SignUpEvent {}

class SaveUserName extends SignUpEvent {
  final String userName;

  SaveUserName(this.userName);
}

class SavePassword extends SignUpEvent {
  final String password;

  SavePassword(this.password);
}

class SaveRepeatPassword extends SignUpEvent {
  final String password;

  SaveRepeatPassword(this.password);
}

class TogglePasswordVisibility extends SignUpEvent {}
/*
class LoggedOut extends SignUpEvent {}

class LoggedInError extends SignUpEvent {}

class WrongCredentialsError extends SignUpEvent {}
*/

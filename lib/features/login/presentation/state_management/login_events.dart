sealed class LoginEvent {}

class Login extends LoginEvent {}

class SaveUserName extends LoginEvent {
  final String userName;

  SaveUserName(this.userName);
}

class SavePassword extends LoginEvent {
  final String password;

  SavePassword(this.password);
}

class TogglePasswordVisibility extends LoginEvent {}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/error/failure_user_message.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';
import 'package:reviewmagic_flutter/features/login/data/repositories/login_repository.dart';
import 'package:reviewmagic_flutter/features/login/presentation/state_management/login_events.dart';
import 'package:reviewmagic_flutter/features/login/presentation/state_management/login_state.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repository) : super(const LoginState()) {
    on<Login>(_loginReducer);
    on<SaveUserName>(_enterUserNameReducer);
    on<SavePassword>(_enterPasswordNameReducer);
  }

  final AuthRepository _repository;

  Future _loginReducer(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(inProgress: true, errorMessage: null));

    try {
      await _repository.login(state.userName!, state.password!);
    } on Failure catch (e) {
      emit(state.copyWith(errorMessage: e.userMsg, inProgress: false));
    }
  }

  void _enterUserNameReducer(SaveUserName event, Emitter<LoginState> emit) =>
      emit(state.copyWith(userName: event.userName));

  void _enterPasswordNameReducer(SavePassword event, Emitter<LoginState> emit) =>
      emit(state.copyWith(password: event.password));
}

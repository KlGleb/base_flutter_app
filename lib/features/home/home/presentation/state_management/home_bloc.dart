import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/error/failure_user_message.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';
import 'package:reviewmagic_flutter/features/home/home/domain/device_repository.dart';
import 'package:reviewmagic_flutter/features/home/home/presentation/state_management/home_events.dart';
import 'package:reviewmagic_flutter/features/home/home/presentation/state_management/home_state.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DeviceRepository _repository;

  HomeBloc(this._repository) : super(const HomeState()) {
    on<UpdateDevices>(_onUpdateDevices);
    add(UpdateDevices());
  }

  void _onUpdateDevices(UpdateDevices event, Emitter<HomeState> emit) async {
    emit(state.copyWith(devices: [], errorMessage: null, busy: true));

    try {
      final res = await _repository.getDevices();
      emit(state.copyWith(errorMessage: null, devices: res.toList(), busy: false));
    } on Failure catch (e) {
      emit(state.copyWith(errorMessage: e.userMsg, busy: false));
    }
  }
}

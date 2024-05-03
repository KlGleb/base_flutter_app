import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reviewmagic_flutter/features/home/home/domain/device_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<DeviceModel> devices,
    String? errorMessage,
    @Default(false) bool busy,
  }) = _HomeState;
}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reviewmagic_flutter/features/home/home/domain/device_model.dart';

part 'device_dto.freezed.dart';
part 'device_dto.g.dart';

@freezed
class DeviceDto with _$DeviceDto {
  const factory DeviceDto({
    required String id,
    required bool state,
  }) = _DeviceDto;

  factory DeviceDto.fromJson(Map<String, dynamic> json) => _$DeviceDtoFromJson(json);
}

extension DeviceDtoMapper on DeviceDto {
  DeviceModel get model => DeviceModel(id: id, state: state);
}

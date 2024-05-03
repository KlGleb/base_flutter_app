import 'package:reviewmagic_flutter/features/home/home/domain/device_model.dart';

abstract class DeviceRepository {
  Future<Iterable<DeviceModel>> getDevices();
}

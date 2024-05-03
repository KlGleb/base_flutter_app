import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/home/home/data/dtos/device_dto.dart';
import 'package:reviewmagic_flutter/features/home/home/data/home_ds.dart';
import 'package:reviewmagic_flutter/features/home/home/domain/device_model.dart';
import 'package:reviewmagic_flutter/features/home/home/domain/device_repository.dart';

@LazySingleton(as: DeviceRepository)
class DeviceRepositoryImpl extends DeviceRepository {
  final HomeDataSource _dataSource;

  DeviceRepositoryImpl(this._dataSource);

  @override
  Future<Iterable<DeviceModel>> getDevices() async {
    return (await _dataSource.getDevices()).map((e) => e.model);
  }
}

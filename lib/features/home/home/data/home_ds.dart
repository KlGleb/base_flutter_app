import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/home/home/data/dtos/device_dto.dart';

@Injectable()
class HomeDataSource {
  Future<Iterable<DeviceDto>> getDevices() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.generate(15, (index) => DeviceDto(id: index.toString(), state: index % 3 == 0));
  }
}

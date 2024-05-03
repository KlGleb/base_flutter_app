import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/home/bills/data/dtos/bill_dto.dart';

@Injectable()
class BillsDataSource {
  Future<Iterable<BillDto>> getBills() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.generate(
      15,
      (index) => BillDto(
        id: index.toString(),
        name: 'Общество с ограниченной ответственностью «МИР»',
        account: '40602810206000050025',
        bankName: 'Уральский банк ПАО Сбербанк г. Екатеринбург',
        corBill: '30101810500000000674',
        bik: '046577674',
        amount: 10000,
        created: DateTime.now(),
      ),
    );
  }
}

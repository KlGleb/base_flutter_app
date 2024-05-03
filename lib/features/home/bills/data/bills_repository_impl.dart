import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/home/bills/data/bills_ds.dart';
import 'package:reviewmagic_flutter/features/home/bills/data/dtos/bill_dto.dart';
import 'package:reviewmagic_flutter/features/home/bills/domain/bill_model.dart';
import 'package:reviewmagic_flutter/features/home/bills/domain/bill_repository.dart';

@LazySingleton(as: BillsRepository)
class BillsRepositoryImpl extends BillsRepository {
  final BillsDataSource _dataSource;

  BillsRepositoryImpl(this._dataSource);

  @override
  Future<Iterable<BillModel>> getBills() async {
    return (await _dataSource.getBills()).map((e) => e.model);
  }
}

extension BillsExt on BillDto {
  BillModel get model => BillModel(
        id: id,
        name: name,
        account: account,
        bankName: bankName,
        corBill: corBill,
        bik: bik,
        amount: amount,
        created: created,
      );
}

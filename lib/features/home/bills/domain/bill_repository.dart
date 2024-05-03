import 'package:reviewmagic_flutter/features/home/bills/domain/bill_model.dart';

abstract class BillsRepository {
  Future<Iterable<BillModel>> getBills();
}

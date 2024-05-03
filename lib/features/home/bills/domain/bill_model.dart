import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_model.freezed.dart';

@freezed
class BillModel with _$BillModel {
  const factory BillModel({
    required String id,
    required String name,
    required String account,
    required String bankName,
    required String corBill,
    required String bik,
    required int amount,
    required DateTime created,
  }) = _BillModel;
}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_dto.freezed.dart';
part 'bill_dto.g.dart';

@freezed
class BillDto with _$BillDto {
  const factory BillDto({
    required String id,
    required String name,
    required String account,
    required String bankName,
    required String corBill,
    required String bik,
    required int amount,
    required DateTime created,
  }) = _BillDto;

  factory BillDto.fromJson(Map<String, dynamic> json) => _$BillDtoFromJson(json);
}

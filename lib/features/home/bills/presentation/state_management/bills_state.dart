import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reviewmagic_flutter/features/home/bills/domain/bill_model.dart';

part 'bills_state.freezed.dart';

@freezed
class BillsState with _$BillsState {
  const factory BillsState({
    @Default([]) List<BillModel> bills,
    String? errorMessage,
    @Default(false) bool busy,
    BillModel? overAll,
  }) = _BillsState;
}

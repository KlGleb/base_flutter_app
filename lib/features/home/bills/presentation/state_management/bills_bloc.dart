import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/features/error/failure_user_message.dart';
import 'package:reviewmagic_flutter/features/error/failures.dart';
import 'package:reviewmagic_flutter/features/home/bills/domain/bill_model.dart';
import 'package:reviewmagic_flutter/features/home/bills/domain/bill_repository.dart';
import 'package:reviewmagic_flutter/features/home/bills/presentation/state_management/bills_events.dart';
import 'package:reviewmagic_flutter/features/home/bills/presentation/state_management/bills_state.dart';

@Injectable()
class BillsBloc extends Bloc<BillsEvent, BillsState> {
  final BillsRepository _repository;

  BillsBloc(this._repository) : super(const BillsState()) {
    on<UpdateBills>(_onUpdateBills);
    add(UpdateBills());
  }

  void _onUpdateBills(UpdateBills event, Emitter<BillsState> emit) async {
    emit(state.copyWith(busy: true, errorMessage: null));

    try {
      final res = await _repository.getBills();
      BillModel? overall;

      if (res.isNotEmpty) {
        var amount = 0;
        for (var b in res) {
          amount += b.amount;
        }
        overall = res.first.copyWith(amount: amount);
      }

      emit(state.copyWith(errorMessage: null, bills: res.toList(), busy: false, overAll: overall));
    } on Failure catch (e) {
      emit(state.copyWith(errorMessage: e.userMsg, busy: false));
    }
  }
}

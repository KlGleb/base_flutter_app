import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reviewmagic_flutter/core/widgets/shimmers/shimmer.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/home/bills/domain/bill_model.dart';
import 'package:reviewmagic_flutter/features/home/bills/presentation/state_management/bills_bloc.dart';
import 'package:reviewmagic_flutter/features/home/bills/presentation/state_management/bills_state.dart';
import 'package:routemaster/routemaster.dart';

final _formatCurrency = NumberFormat.simpleCurrency(
  locale: 'RU',
  name: 'RUB',
  decimalDigits: 0,
);

final _formatDate = DateFormat.yMMMd('RU');

class BillsPage extends StatelessWidget {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<BillsBloc>(
        create: (BuildContext context) => getIt(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Счета')),
          body: Column(
            children: [
              BlocBuilder<BillsBloc, BillsState>(
                builder: (BuildContext context, BillsState state) {
                  if (state.errorMessage != null) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            state.errorMessage!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      ),
                    );
                  }

                  if (state.busy) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(28),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: null,
                                  child: const Text('Оплатить полностью').shimmerIf(true, width: 200),
                                ),
                              ),
                            );
                          }
                          return const _BillCard(bill: null);
                        },
                      ),
                    );
                  }

                  if (state.bills.isEmpty) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'У вас нет неоплаченных счетов',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.bills.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(28),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Routemaster.of(context).push('bill');
                                },
                                child: Text('Оплатить ${_formatCurrency.format(state.overAll?.amount ?? 0)} '
                                    'полностью'),
                              ),
                            ),
                          );
                        }
                        final item = state.bills[index - 1];
                        return _BillCard(key: ValueKey(item.id), bill: item);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

class _BillCard extends StatelessWidget {
  const _BillCard({super.key, this.bill});

  final BillModel? bill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatCurrency.format(bill?.amount ?? 0),
                style: Theme.of(context).textTheme.titleMedium,
              ).shimmerIf(bill == null),
              const SizedBox(height: 4),
              Text(
                'От ${_formatDate.format(bill?.created ?? DateTime.now())}',
                style: Theme.of(context).textTheme.bodyMedium,
              ).shimmerIf(bill == null, width: 200),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: bill == null
                          ? null
                          : () {
                              Routemaster.of(context).push('bill');
                            },
                      child: const Text('Оплатить')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

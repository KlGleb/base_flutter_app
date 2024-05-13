import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reviewmagic_flutter/features/home/bills/domain/bill_model.dart';
import 'package:reviewmagic_flutter/features/home/bills/presentation/bills_screen.dart';

void main() {
  testWidgets('BillCard has correct title and subtitle', (tester) async {
    await initializeDateFormatting();
    final bill = BillModel(
      id: 'id',
      name: 'name',
      account: 'account',
      bankName: 'bankName',
      corBill: 'corBill',
      bik: 'bik',
      amount: 100000,
      created: DateTime.parse('2020-07-17T03:18:31.177769-04:00'),
    );
    await tester.pumpWidget(MaterialApp(home: BillCard(bill: bill)));

    expect(find.text('100 000 ₽'), findsOneWidget);
    expect(find.text('От 17 июл. 2020 г.'), findsOneWidget);
  });
}

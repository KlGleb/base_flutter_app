import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  Widget build(BuildContext context) {
    final pageState = IndexedPage.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SegmentedButton<int>(
              segments: const [
                ButtonSegment<int>(
                  value: 0,
                  label: Text('QR-код'),
                  icon: Icon(Icons.qr_code_outlined),
                ),
                ButtonSegment<int>(
                  value: 1,
                  label: Text('Реквизиты'),
                  icon: Icon(Icons.list_outlined),
                ),
              ],
              selected: {pageState.index},
              onSelectionChanged: (p0) {
                setState(() {
                  pageState.index = p0.first;
                });
              },
            ),
            const SizedBox(height: 48),
            Expanded(
              child: PageStackNavigator(
                key: ValueKey(pageState.index),
                stack: pageState.stacks[pageState.index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

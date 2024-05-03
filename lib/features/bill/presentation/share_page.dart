import 'package:flutter/material.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text('12 350 ₽', style: theme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 20),
        const ListTile(
          title: Text('Наименование организации'),
          subtitle: Text('Общество с ограниченной ответственностью «МИР»'),
          trailing: Icon(Icons.copy_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        const ListTile(
          title: Text('Рассчетный счет'),
          subtitle: Text('40602810206000050025'),
          trailing: Icon(Icons.copy_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        const ListTile(
          title: Text('Наименование банка'),
          subtitle: Text('Уральский банк ПАО Сбербанк г. Екатеринбург'),
          trailing: Icon(Icons.copy_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        const ListTile(
          title: Text('Корреспондентский счет'),
          subtitle: Text('30101810500000000674'),
          trailing: Icon(Icons.copy_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        const ListTile(
          title: Text('БИК'),
          subtitle: Text('046577674'),
          trailing: Icon(Icons.copy_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        const ListTile(
          title: Text('К оплате, руб.'),
          subtitle: Text('12350'),
          trailing: Icon(Icons.copy_outlined),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

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
        ListTile(
          title: const Text('Наименование организации'),
          subtitle: const Text('Общество с ограниченной ответственностью «МИР»'),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_outlined)),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('Рассчетный счет'),
          subtitle: const Text('40602810206000050025'),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_outlined)),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('Наименование банка'),
          subtitle: const Text('Уральский банк ПАО Сбербанк г. Екатеринбург'),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_outlined)),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('Корреспондентский счет'),
          subtitle: const Text('30101810500000000674'),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_outlined)),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('БИК'),
          subtitle: const Text('046577674'),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_outlined)),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          title: const Text('К оплате, руб.'),
          subtitle: const Text('12350'),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_outlined)),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

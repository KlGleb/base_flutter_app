import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/features/auth/state_management/auth_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Контрагент', style: textTheme.titleMedium),
              Text('КРБП-000029\nЕфимова Любовь Сергеевна', style: textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text('Организация', style: textTheme.titleMedium),
              Text('КОФЕРЕНТ ООО', style: textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text('Цветовая схема', style: textTheme.titleLarge),
              const SizedBox(height: 8),
              const DropdownMenu(
                initialSelection: 'default',
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'default', label: '🌒 Как на устройстве'),
                  DropdownMenuEntry(value: 'light', label: '🌞 Светлая'),
                  DropdownMenuEntry(value: 'dark', label: '🌒 Темная'),
                ],
              ),
              const SizedBox(height: 24),
              Text('Оповещения', style: textTheme.titleLarge),
              CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: const Text('Включить оповещения на этом устройстве'),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                value: true,
                onChanged: (value) {},
                title: const Text('Включить оповещения по email'),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Удалить аккаунт'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(Logout());
                  },
                  child: const Text('Выйти из аккаунта'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

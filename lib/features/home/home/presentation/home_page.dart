import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/core/widgets/logo.dart';
import 'package:reviewmagic_flutter/core/widgets/permissions.dart';
import 'package:reviewmagic_flutter/core/widgets/shimmers/shimmer.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/home/home/presentation/state_management/home_bloc.dart';
import 'package:reviewmagic_flutter/features/home/home/presentation/state_management/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (BuildContext context) => getIt(),
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Center(child: Logo()),
            const SizedBox(height: 8),
            const NotificationsPermissionsCard(),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, HomeState state) {
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
                    child: ListView.separated(
                      itemCount: 4,
                      itemBuilder: (context, index) => _DeviceItem(id: null, switchedOn: index % 2 == 0),
                      separatorBuilder: (BuildContext context, int index) => const Divider(indent: 16, endIndent: 16),
                    ),
                  );
                }

                if (state.devices.isEmpty) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Нет арендованных устройств',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: state.devices.length,
                    itemBuilder: (context, index) {
                      final item = state.devices[index];
                      return _DeviceItem(key: ValueKey(item.id), id: item.id.toString(), switchedOn: item.state);
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(indent: 16, endIndent: 16),
                  ),
                );
              },
            ),
          ],
        ),
      );
}

class _DeviceItem extends StatelessWidget {
  const _DeviceItem({super.key, required this.id, required this.switchedOn});

  final String? id;
  final bool switchedOn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final color = switchedOn ? theme.primary : theme.error;
    return ListTile(
      title: Text('Кофемашина ${id ?? '1'}').shimmerIf(id == null, width: 300),
      subtitle: Text(
        switchedOn ? 'Включена' : 'Выключена',
        style: TextStyle(color: color),
      ).shimmerIf(id == null, width: 200),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviewmagic_flutter/features/auth/state_management/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(Logout()),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }
}

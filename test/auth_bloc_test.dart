import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reviewmagic_flutter/features/auth/state_management/auth_bloc.dart';
import 'package:reviewmagic_flutter/features/login/domain/repositories/auth_repository.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
])
export 'auth_bloc_test.mocks.dart';

void main() {
  group('AuthBloc test', () {
    late AuthRepository repository;

    setUp(() {
      repository = MockAuthRepository();
    });

    blocTest(
      'init state',
      build: () => AuthBloc(repository),
      act: (bloc) => bloc.add(Init()),
      expect: () => [AuthState.init],
    );

    blocTest(
      'react on LoggedIn event',
      build: () => AuthBloc(repository),
      act: (bloc) => bloc.add(LoggedIn()),
      expect: () => [AuthState.loggedIn],
    );
    blocTest(
      'react on LoggedOut event',
      build: () => AuthBloc(repository),
      act: (bloc) => bloc.add(LoggedOut()),
      expect: () => [AuthState.loggedOut],
    );

    blocTest(
      'react on LogOut event',
      build: () => AuthBloc(repository),
      act: (bloc) => bloc.add(Logout()),
      verify: (bloc) => verify(repository.logOut()),
    );
  });
}

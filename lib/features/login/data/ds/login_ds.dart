import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:reviewmagic_flutter/core/data/data_source_mixin.dart';

import 'auth.graphql.dart';

@Injectable()
class LoginDataSource with DataSource {
  final GraphQLClient _client;

  LoginDataSource(this._client);

  Future<Query$LogIn> login(Variables$Query$LogIn vars) => executeQuery(
        queryBuilder: _client.query$LogIn(Options$Query$LogIn(variables: vars)),
        fromJson: Query$LogIn.fromJson,
      );

  Future<Query$SignUp> register(Variables$Query$SignUp vars) => executeQuery(
        queryBuilder: _client.query$SignUp(Options$Query$SignUp(variables: vars)),
        fromJson: Query$SignUp.fromJson,
      );

  Future<Query$SendResetPasswordCode> sendCodeToEmail(Variables$Query$SendResetPasswordCode vars) => executeQuery(
        queryBuilder: _client.query$SendResetPasswordCode(Options$Query$SendResetPasswordCode(variables: vars)),
        fromJson: Query$SendResetPasswordCode.fromJson,
      );

  Future<Mutation$ResetPassword> resetPasswordByCode(Variables$Mutation$ResetPassword vars) => executeQuery(
        queryBuilder: _client.mutate$ResetPassword(Options$Mutation$ResetPassword(variables: vars)),
        fromJson: Mutation$ResetPassword.fromJson,
      );
}

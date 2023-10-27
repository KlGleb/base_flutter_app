import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:reviewmagic_flutter/features/login/data/dtos/login_dto.dart';
import 'package:reviewmagic_flutter/features/login/data/entities/login_entity.dart';
import 'package:reviewmagic_flutter/features/login/data/entities/reset_password_entity.dart';

part 'login_ds.g.dart';

@RestApi()
@LazySingleton()
abstract class LoginDataSource {
  @factoryMethod
  factory LoginDataSource(Dio dio) = _LoginDataSource;

  @POST('/auth/login')
  Future<LoginEntity> login(@Body() LoginDto loginDto);

  @POST('/auth/register')
  Future<LoginEntity> register(@Body() LoginDto loginDto);

  @POST('/auth/reset')
  Future<bool> sendCodeToEmail(@Body() String email);

  @PUT('/auth/reset')
  Future<LoginEntity> resetPasswordByCode(@Body() ResetPasswordEntity entity);
}

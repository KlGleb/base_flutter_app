import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:reviewmagic_flutter/features/dio_interceptors/dio_error_interceptor.dart';

import 'dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://0.0.0.0:8080',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      AwesomeDioInterceptor(
        logger: (log) => debugPrint(log),
      ),
    );

    dio.interceptors.add(ResponseInterceptor());
    return dio;
  }
}

@module
abstract class SecureStorageModule {
  FlutterSecureStorage get storage => const FlutterSecureStorage();
}

final logger = Logger();

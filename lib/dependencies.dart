import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

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
        baseUrl: 'https://0.0.0.0:8443',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip',
        },
      ),
    )..httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: const Duration(seconds: 10),
          onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
        ),
      );

    dio.interceptors.addAll([
      AwesomeDioInterceptor(logger: (log) => debugPrint(log)),
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.response != null) {
            error.response?.statusCode = 200;
            handler.resolve(error.response!);
          } else {
            error.response?.statusCode = 200;
            handler.next(error);
          }
        },
      ),
    ]);

    return dio;
  }

  GraphQLClient get graphQlClient {
    final link = Link.from([
      // SomeLink(),
      DioLink('/graphql', client: dio, serializableErrors: true),
    ]);

    final policies = Policies(
      fetch: FetchPolicy.noCache,
      error: ErrorPolicy.all,
    );

    final client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: policies,
        mutate: policies,
        watchQuery: policies,
        watchMutation: policies,
        subscribe: policies,
      ),
    );
    return client;
  }
}

@module
abstract class SecureStorageModule {
  FlutterSecureStorage get storage => const FlutterSecureStorage();
}

final logger = Logger();

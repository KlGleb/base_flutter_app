import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/auth/state_management/auth_bloc.dart';
import 'package:reviewmagic_flutter/generated/codegen_loader.g.dart';
import 'package:reviewmagic_flutter/router.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  usePathUrlStrategy();
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: BlocProvider(
        create: (context) => getIt<AuthBloc>(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState == AuthState.init) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            }

            logger.w(authState);
            return MaterialApp.router(
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) => authState == AuthState.loggedIn ? routes : unauthorisedRoutes,
              ),
              routeInformationParser: const RoutemasterParser(),
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              showSemanticsDebugger: false,
            );
          },
        ),
      ),
    );
  }
}

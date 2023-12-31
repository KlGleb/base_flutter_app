import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/home/home_screen.dart';
import 'package:reviewmagic_flutter/features/login/presentation/login_mobile_screen.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/reset_password_code_mobile_screen.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/sign_up_mobile_screen.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(
  onUnknownRoute: (_) => const Redirect('/'),
  routes: {
    '/': (_) => const MaterialPage(child: HomeScreen()),
  },
);

final unauthorisedRoutes = RouteMap(
  onUnknownRoute: (_) => const Redirect('/login'),
  routes: {
    '/login': (_) => const MaterialPage(child: LoginMobileScreen()),
    '/signup': (_) => const MaterialPage(child: SignUpMobileScreen()),
    '/resetPassword': (data) => MaterialPage(child: ResetPasswordMobileScreen(code: data.queryParameters['code'])),
  },
);

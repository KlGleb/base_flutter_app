import 'package:flutter/material.dart';
import 'package:reviewmagic_flutter/features/bill/presentation/bill_screen.dart';
import 'package:reviewmagic_flutter/features/bill/presentation/qr_code_page.dart';
import 'package:reviewmagic_flutter/features/bill/presentation/share_page.dart';
import 'package:reviewmagic_flutter/features/home/bills/presentation/bills_screen.dart';
import 'package:reviewmagic_flutter/features/home/home/presentation/home_page.dart';
import 'package:reviewmagic_flutter/features/home/home_screen.dart';
import 'package:reviewmagic_flutter/features/home/settings/presentation/settings_page.dart';
import 'package:reviewmagic_flutter/features/login/presentation/login_mobile_screen.dart';
import 'package:reviewmagic_flutter/features/login/presentation_reset_password_code/reset_password_code_mobile_screen.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/sign_up_mobile_screen.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(
  onUnknownRoute: (_) => const Redirect('/'),
  routes: {
    '/': (_) => const IndexedPage(
          child: HomeScreen(),
          paths: ['/home', '/bills', '/settings'],
        ),
    '/home': (_) => const MaterialPage(child: HomePage()),
    '/bills': (_) => const MaterialPage(child: BillsPage()),
    '/settings': (_) => const MaterialPage(child: SettingsPage()),
    '/bills/bill': (_) => const IndexedPage(
          child: BillScreen(),
          paths: ['/bills/bill/qr', '/bills/bill/req'],
        ),
    '/bills/bill/qr': (_) => const MaterialPage(child: QrCodePage()),
    '/bills/bill/req': (_) => const MaterialPage(child: SharePage()),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:reviewmagic_flutter/dependencies.dart';
import 'package:reviewmagic_flutter/features/home/home_screen.dart';
import 'package:reviewmagic_flutter/features/login/presentation/login_form.dart';
import 'package:reviewmagic_flutter/features/login/presentation_sign_up/sign_up_form.dart';
import 'package:reviewmagic_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';
import 'widget_tester_utils.dart';

void main() {
  // const MethodChannel channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  /*TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel,
      (MethodCall methodCall) async {
    // final method = methodCall.method;
    // final args = methodCall.arguments;

    /// do something...
  });*/
  testWidgets('Регистрация и открытие счета', (tester) async {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    SharedPreferences.setMockInitialValues({});
    configureDependencies();
    await EasyLocalization.ensureInitialized();
    // Load app widget.
    await tester.pumpWidget(const MyApp());
    await tester.pumpUntilFound(find.byKey(SignUpLabel.findKey));
    await tester.tap(find.byKey(SignUpLabel.findKey));
    await tester.pumpUntilFound(find.text('Регистрация'));

    final email = '${getRandomString(10)}@test.at';
    final password = getRandomString(5);

    await tester.scrollTapAndEnter(find.byKey(SignUpForm.emailField), email);
    await tester.scrollTapAndEnter(find.byKey(SignUpForm.passField), password);
    await tester.scrollTapAndEnter(find.byKey(SignUpForm.pass2Field), password);

    await tester.tap(find.byKey(SignUpForm.checkKey));
    await tester.tap(find.byKey(SignUpForm.registerKey));

    await tester.pumpUntilFound(find.byKey(HomeScreen.billsKey));
    await tester.tap(find.byKey(HomeScreen.billsKey));

    await tester.pumpUntilFound(find.text('Оплатить'));
    await tester.pumpUntilButtonEnabled(find.byType(ElevatedButton).first);
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpUntilFound(find.text('Оплата'));
  });
}

bool findTextAndTap(InlineSpan visitor, String text) {
  if (visitor is TextSpan && visitor.text == text) {
    (visitor.recognizer as TapGestureRecognizer).onTap?.call();

    return false;
  }

  return true;
}

bool tapTextSpan(RichText richText, String text) {
  final isTapped = !richText.text.visitChildren(
    (visitor) => findTextAndTap(visitor, text),
  );

  return isTapped;
}

Future<void> ignoreException(Type exceptionType) async {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails details) {
    final currentError = details.exception.runtimeType;
    if (currentError == exceptionType) {
      return;
    }
    originalOnError(details);
  };
}

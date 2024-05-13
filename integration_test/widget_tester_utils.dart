import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _requestDuration = Duration(seconds: 5);

extension WidgetTesterUtils on WidgetTester {
  void expectTextError(Finder finder) {
    expect(widget<TextField>(finder).decoration?.errorText, isNotNull);
  }

  void expectTextNoError(Finder finder) {
    expect(widget<TextField>(finder).decoration?.errorText, isNull);
  }

  Future<void> req() async => await pumpAndSettle(_requestDuration);

  Future<void> waitEnabledAndTap(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
    bool scrollUntilVisible = true,
    Type? scrollType,
  }) async {
    await pumpUntilFound(finder, timeout: timeout);
    await pumpUntilButtonEnabled(finder, timeout: timeout);
    if (scrollUntilVisible) {
      await dragUntilVisible(
        finder, // what you want to find
        find.byType(scrollType ?? SingleChildScrollView),
        // widget you want to scroll
        const Offset(0, 50), // delta to move
      );
    }
    await tap(finder);
  }

  Future<void> scrollTapAndEnter(Finder finder, String text, {Duration timeout = const Duration(seconds: 10)}) async {
    await pumpUntilFound(finder, timeout: timeout);
    await pumpUntilTextFieldEnabled(finder, timeout: timeout);
    await dragUntilVisible(
      finder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(0, 50), // delta to move
    );
    await tap(finder);
    await enterText(finder, text);
    await pumpAndSettle();
  }

  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    bool timerDone = false;
    final timer = Timer(timeout, () => timerDone = true);
    while (timerDone != true) {
      await pump();

      final found = any(finder);
      if (found) {
        timerDone = true;
      }
    }
    timer.cancel();
    if (!any(finder)) {
      throw Exception('Not found: $finder');
    }
  }

  Future<void> pumpUntilButtonEnabled(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    bool timerDone = false;
    final timer = Timer(timeout, () => timerDone = true);
    while (timerDone != true) {
      await pump();

      final button = widget<ButtonStyleButton>(finder);
      if (button.onPressed != null) {
        timerDone = true;
      }
    }
    timer.cancel();
  }

  Future<void> pumpUntilTextFieldEnabled(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    bool timerDone = false;
    final timer = Timer(timeout, () => timerDone = true);
    while (timerDone != true) {
      await pump();

      final button = widget<TextFormField>(finder);
      if (button.enabled == true) {
        timerDone = true;
      }
    }
    timer.cancel();
  }
}

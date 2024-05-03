import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    final isDark = brightness == Brightness.dark;
    final img = isDark ? 'assets/icons/logo_dark.svg' : 'assets/icons/logo_light.svg';
    return SvgPicture.asset(img);
  }
}

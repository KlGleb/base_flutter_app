import 'package:flutter/material.dart';

class MaterialTheme {
  const MaterialTheme();

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff39693B),
      onPrimary: Color(0xffFFFFFF),
      primaryContainer: Color(0xffBAF0B6),
      onPrimaryContainer: Color(0xff002106),
      primaryFixed: Color(0xffBAF0B6),
      onPrimaryFixed: Color(0xff002106),
      primaryFixedDim: Color(0xff9FD49C),
      onPrimaryFixedVariant: Color(0xff215025),
      secondary: Color(0xff526350),
      onSecondary: Color(0xffFFFFFF),
      secondaryContainer: Color(0xffD5E8CF),
      onSecondaryContainer: Color(0xff101F10),
      secondaryFixed: Color(0xffD5E8CF),
      onSecondaryFixed: Color(0xff101F10),
      secondaryFixedDim: Color(0xffB9CCB4),
      onSecondaryFixedVariant: Color(0xff3B4B39),
      tertiary: Color(0xff39656B),
      onTertiary: Color(0xffFFFFFF),
      tertiaryContainer: Color(0xffBCEBF1),
      onTertiaryContainer: Color(0xff001F23),
      tertiaryFixed: Color(0xffBCEBF1),
      onTertiaryFixed: Color(0xff001F23),
      tertiaryFixedDim: Color(0xffA1CED5),
      onTertiaryFixedVariant: Color(0xff1F4D53),
      error: Color(0xffBA1A1A),
      onError: Color(0xffFFFFFF),
      errorContainer: Color(0xffFFDAD6),
      onErrorContainer: Color(0xff410002),
      outline: Color(0xff72796F),
      surface: Color(0xffF7FBF1),
      onSurface: Color(0xff181D17),
      onSurfaceVariant: Color(0xff424940),
      inverseSurface: Color(0xff2D322C),
      inverseOnSurface: Color(0xffEEF2E9),
      inversePrimary: Color(0xff9FD49C),
      shadow: Color(0xff000000),
      outlineVariant: Color(0xffC2C9BD),
      scrim: Color(0xff000000),
      surfaceContainerHighest: Color(0xffE0E4DB),
      surfaceContainerHigh: Color(0xffE6E9E1),
      surfaceContainer: Color(0xffEBEFE6),
      surfaceContainerLow: Color(0xffF1F5EC),
      surfaceContainerLowest: Color(0xffFFFFFF),
      surfaceBright: Color(0xffF7FBF1),
      surfaceDim: Color(0xffD7DBD3),
      surfaceTint: Color(0xff39693b),
      background: Color(0xfff7fbf1),
      onBackground: Color(0xff181d17),
      surfaceVariant: Color(0xffdee5d9),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9FD49C),
      onPrimary: Color(0xff063911),
      primaryContainer: Color(0xff215025),
      onPrimaryContainer: Color(0xffBAF0B6),
      primaryFixed: Color(0xffBAF0B6),
      onPrimaryFixed: Color(0xff002106),
      primaryFixedDim: Color(0xff9FD49C),
      onPrimaryFixedVariant: Color(0xff215025),
      secondary: Color(0xffB9CCB4),
      onSecondary: Color(0xff253424),
      secondaryContainer: Color(0xff3B4B39),
      onSecondaryContainer: Color(0xffD5E8CF),
      secondaryFixed: Color(0xffD5E8CF),
      onSecondaryFixed: Color(0xff101F10),
      secondaryFixedDim: Color(0xffB9CCB4),
      onSecondaryFixedVariant: Color(0xff3B4B39),
      tertiary: Color(0xffA1CED5),
      onTertiary: Color(0xff00363C),
      tertiaryContainer: Color(0xff1F4D53),
      onTertiaryContainer: Color(0xffBCEBF1),
      tertiaryFixed: Color(0xffBCEBF1),
      onTertiaryFixed: Color(0xff001F23),
      tertiaryFixedDim: Color(0xffA1CED5),
      onTertiaryFixedVariant: Color(0xff1F4D53),
      error: Color(0xffFFB4AB),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000A),
      onErrorContainer: Color(0xffFFDAD6),
      outline: Color(0xff8C9388),
      surface: Color(0xff10140F),
      onSurface: Color(0xffE0E4DB),
      onSurfaceVariant: Color(0xffC2C9BD),
      inverseSurface: Color(0xffE0E4DB),
      inverseOnSurface: Color(0xff2D322C),
      inversePrimary: Color(0xff39693B),
      shadow: Color(0xff000000),
      outlineVariant: Color(0xff424940),
      scrim: Color(0xff000000),
      surfaceContainerHighest: Color(0xff323630),
      surfaceContainerHigh: Color(0xff272B25),
      surfaceContainer: Color(0xff1C211B),
      surfaceContainerLow: Color(0xff181D17),
      surfaceContainerLowest: Color(0xff0B0F0A),
      surfaceBright: Color(0xff363A34),
      surfaceDim: Color(0xff10140F),
      surfaceTint: Color(0xffd3bcfd),
      background: Color(0xff151218),
      onBackground: Color(0xffe7e0e8),
      surfaceVariant: Color(0xff49454e),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: const TextTheme().apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

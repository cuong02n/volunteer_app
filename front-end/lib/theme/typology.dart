part of 'theme.dart';

///Nơi lưu kiểu phông của app
abstract class AppTypology {
  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    height: 64/57,
    letterSpacing: -0.25
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    height: 52/45
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    height: 44/36
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    height: 40/32
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    height: 36/28
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    height: 36/24
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    height: 28/22,
    letterSpacing: 0.15
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    height: 24/16,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w700
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    height: 20/14,
    fontWeight: FontWeight.w600
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    height: 20/14,
    letterSpacing: 0.1
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    height: 16/12,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w600
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    height: 16/11,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    height: 24/16,
    letterSpacing: 0.5
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    height: 20/14,
    letterSpacing: 0.25
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    height: 16/12,
    letterSpacing: 0.4
  );

  static const TextStyle appName = TextStyle(
    fontSize: 20,
    height: 24/20,
    fontWeight: FontWeight.w700
  );

  static final TextStyle textButtonLabel =
      labelLarge.copyWith(color: AppColor.orange);
}


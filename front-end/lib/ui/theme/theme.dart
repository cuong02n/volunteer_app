import 'package:flutter/material.dart';

part 'color.dart';
part 'typology.dart';
part 'extension.dart';

///Chuẩn design của app (Theme)
abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.orange,
        primary: AppColor.orange,
        secondary: AppColor.grey,
        surfaceTint: AppColor.white
      ),
      textTheme: AppTypology.textTheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppColor.white
          )
      ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      )
    ),
    cardColor: AppColor.white
  );

  static ThemeData darkTheme = ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.orange, brightness: Brightness.dark));
}

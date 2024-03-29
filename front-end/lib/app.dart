import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/routes/app_branch.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/fixed_sizer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FixedSizer(
      builder: (context, orientation, device) {
        return MaterialApp.router(
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
        );
      }
    );
  }
}
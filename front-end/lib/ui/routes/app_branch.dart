import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'package:thien_nguyen_app/repositories/mix/auth_mix_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/pages/event/donation/donation_page.dart';
import 'package:thien_nguyen_app/ui/pages/event/event_detail_page.dart';
import 'package:thien_nguyen_app/ui/pages/pages.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

///Nơi lưu trữ GoRouter của app, các trang (Page) xong sẽ được xuất vào pages.dart
///và được gọi trong các GoRoute (tùy thuộc vào mục đích sử dụng sẽ dùng builder
///hoặc pageBuilder tương ứng. StatefulShellRoute là trường hợp đặc biệt để điều hướng
///cho các trang dùng thanh điều hướng dưới.
abstract class AppRouter {
  static final router = GoRouter(
      routes: _route,
      initialLocation: RoutePath.home,
      redirect: (context, state) async {
        if (CurrentInfo.user == null) await AuthMixRepository.tryLogin();
        return null;
      },
      navigatorKey: _rootKey);

  static final _rootKey = navigatorKey;

  static final _route = [
    StatefulShellRoute(
        branches: _homeRoute,
        builder: (context, state, navigationShell) => navigationShell,
        navigatorContainerBuilder: (context, navigationShell, pages) =>
            MainPage(pages: pages, navigationShell: navigationShell)),
    GoRoute(
        name: RouteName.login,
        path: RoutePath.login,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => LoginPage(),
        routes: [
          GoRoute(
              name: RouteName.register,
              path: RoutePath.register,
              pageBuilder: (context, state) => RegisterPage(),
              routes: [
                GoRoute(
                  name: RouteName.otp,
                  path: RoutePath.otp,
                  pageBuilder: (context, state) => OtpPage(),
                )
              ]),
          GoRoute(
            name: RouteName.forgetPassword,
            path: RoutePath.forgetPassword,
            builder: (context, state) => ForgotPasswordPage(),
          )
        ]),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: RoutePath.specificPage,
        builder: (context, state) =>
            ChildPagePage(id: int.parse(state.pathParameters['pageID']!)),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootKey,
              path: RoutePath.newEvent,
              name: RouteName.newEvent,
              pageBuilder: (context, state) => NewEventPage(
                  fanpageId: int.parse(state.pathParameters['pageID']!)))
        ]),
    GoRoute(
        parentNavigatorKey: _rootKey,
        name: RouteName.account,
        path: RoutePath.account,
        builder: (context, state) => AccountPage()),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: RoutePath.status,
        builder: (context, state) => PageDetail(event: state.extra as Event),
        routes: [
          GoRoute(path: RoutePath.donation, name: RouteName.donation,
          pageBuilder: (context, state) => DonationPage()
          )
        ]
    ),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: RoutePath.anotherUser,
        builder: (context, state) {
          int id = int.parse(state.pathParameters["id"]!);
          return UserPage(id: id);
        }),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: RoutePath.helpAndSupport,
        name: RouteName.helpAndSupport,
        builder: (context, state) => HelpPage()),
    GoRoute(
        parentNavigatorKey: _rootKey,
        name: RouteName.privacyPolicy,
        path: RoutePath.privacyPolicy,
        builder: (context, state) => PrivacyPage()),
    GoRoute(
        parentNavigatorKey: _rootKey,
        name: RouteName.terms,
        path: RoutePath.terms,
        builder: (context, state) => TermsPage())
  ];

  static final _homeRoute = [
    StatefulShellBranch(routes: [
      GoRoute(
          path: RoutePath.home,
          pageBuilder: (context, state) =>
              _getPage(child: HomePage(), state: state),
          redirect: (context, state) async {
            bool isLogin = await AuthMixRepository.tryLogin();
            if (isLogin) {
              return null;
            } else {
              return RoutePath.login;
            }
          })
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          name: RouteName.notification,
          path: RoutePath.notification,
          pageBuilder: (context, state) =>
              _getPage(child: NotificationPage(), state: state))
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          name: RouteName.page,
          path: RoutePath.page,
          pageBuilder: (context, state) =>
              _getPage(child: FanpagePage(), state: state),
          routes: [
            GoRoute(
                parentNavigatorKey: _rootKey,
                name: RoutePath.newPage,
                path: RoutePath.newPage,
                pageBuilder: (context, state) => NewPagePage()),
          ])
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          name: RouteName.settings,
          path: RoutePath.settings,
          pageBuilder: (context, state) =>
              _getPage(child: SettingsPage(), state: state)),
      GoRoute(
          name: RouteName.user,
          path: RoutePath.user,
          pageBuilder: (context, state) {
            int id = CurrentInfo.user!.id!;
            return _getPage(child: UserPage(id: id), state: state);
          },
          routes: [
            GoRoute(
                parentNavigatorKey: _rootKey,
                path: RoutePath.edit,
                builder: (context, state) => EditUserPage())
          ])
    ]),
  ];

  static _getPage({required Widget child, required GoRouterState state}) {
    return MaterialPage(key: state.pageKey, child: child);
  }
}

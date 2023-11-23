import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/pages/pages.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';

///Nơi lưu trữ GoRouter của app, các trang (Page) xong sẽ được xuất vào pages.dart
///và được gọi trong các GoRoute (tùy thuộc vào mục đích sử dụng sẽ dùng builder
///hoặc pageBuilder tương ứng. StatefulShellRoute là trường hợp đặc biệt để điều hướng
///cho các trang dùng thanh điều hướng dưới.
abstract class AppRouter {
  static final router =
      GoRouter(routes: _route, initialLocation: RoutePath.home, navigatorKey: _rootKey);

  static final _rootKey = GlobalKey<NavigatorState>();

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
              pageBuilder: (context, state) => RegisterPage()),
        ]),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: RoutePath.specificPage,
        builder: (context, state) => ChildPagePage()),
    GoRoute(
        parentNavigatorKey: _rootKey,
        name: RouteName.account,
        path: RoutePath.account,
        builder: (context, state) => AccountPage()),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: RoutePath.status, builder: (context, state) => Error404Page()),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: RoutePath.anotherUser,
        builder: (context, state) => Error404Page()),
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
        path: RoutePath.terms, builder: (context, state) => TermsPage())
  ];

  static final _homeRoute = [
    StatefulShellBranch(routes: [
      GoRoute(
          path: RoutePath.home,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state))
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
          ]
      )
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
          pageBuilder: (context, state) =>
              _getPage(child: UserPage(), state: state),
          routes: [
            GoRoute(
                parentNavigatorKey: _rootKey,
                path: RoutePath.edit,
                builder: (context, state) =>
                    EditUserPage())
          ])
    ]),
  ];

  static _getPage({required Widget child, required GoRouterState state}) {
    return MaterialPage(key: state.pageKey, child: child);
  }
}

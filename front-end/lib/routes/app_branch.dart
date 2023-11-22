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
      GoRouter(routes: _route, initialLocation: RoutePath.login);

  static final _route = [
    StatefulShellRoute(
        branches: _homeRoute,
        builder: (context, state, navigationShell) => navigationShell,
        navigatorContainerBuilder: (context, navigationShell, pages) =>
            MainPage(pages: pages, navigationShell: navigationShell)),
    GoRoute(
        name: RouteName.login,
        path: RoutePath.login,
        builder: (context, state) => LoginPage(),
        routes: [
          GoRoute(
              name: RouteName.register,
              path: RoutePath.register,
              pageBuilder: (context, state) => RegisterPage()),
        ]),
    GoRoute(
        path: RoutePath.status, builder: (context, state) => Error404Page()),
    GoRoute(
        path: RoutePath.anotherUser,
        builder: (context, state) => Error404Page()),
    GoRoute(
        path: RoutePath.settings, builder: (context, state) => Error404Page()),
    GoRoute(
        path: RoutePath.newPage, builder: (context, state) => Error404Page()),
    GoRoute(
        path: RoutePath.specificPage,
        builder: (context, state) => Error404Page()),
    GoRoute(
        path: RoutePath.helpAndSupport,
        builder: (context, state) => Error404Page()),
    GoRoute(
        path: RoutePath.privacyPolicy,
        builder: (context, state) => Error404Page()),
    GoRoute(path: RoutePath.terms, builder: (context, state) => Error404Page())
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
          path: RoutePath.notification,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state))
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          path: RoutePath.page,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state))
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          path: RoutePath.user,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state),
          routes: [
            GoRoute(
                path: RoutePath.edit,
                pageBuilder: (context, state) =>
                    _getPage(child: Error404Page(), state: state))
          ])
    ]),
  ];

  static _getPage({required Widget child, required GoRouterState state}) {
    return MaterialPage(key: state.pageKey, child: child);
  }
}

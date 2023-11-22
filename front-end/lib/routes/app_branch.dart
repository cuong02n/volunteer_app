import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/pages/pages.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';

abstract class AppRouter {
  static final router =
      GoRouter(routes: _route, initialLocation: RouteName.login);

  static final _route = [
    StatefulShellRoute(
        branches: _homeRoute,
        builder: (context, state, navigationShell) => navigationShell,
        navigatorContainerBuilder: (context, navigationShell, pages) =>
            MainPage(pages: pages, navigationShell: navigationShell)),
    GoRoute(path: RouteName.login, builder: (context, state) => const LoginPage()),
    GoRoute(
        path: RouteName.register, builder: (context, state) => Error404Page()),
    GoRoute(
        path: RouteName.status, builder: (context, state) => Error404Page()),
    GoRoute(
        path: RouteName.anotherUser,
        builder: (context, state) => Error404Page()),
    GoRoute(
        path: RouteName.settings, builder: (context, state) => Error404Page()),
    GoRoute(
        path: RouteName.newPage, builder: (context, state) => Error404Page()),
    GoRoute(
        path: RouteName.specificPage,
        builder: (context, state) => Error404Page()),
    GoRoute(
        path: RouteName.helpAndSupport,
        builder: (context, state) => Error404Page()),
    GoRoute(
        path: RouteName.privacyPolicy,
        builder: (context, state) => Error404Page()),
    GoRoute(path: RouteName.terms, builder: (context, state) => Error404Page())
  ];

  static final _homeRoute = [
    StatefulShellBranch(routes: [
      GoRoute(
          path: RouteName.home,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state))
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          path: RouteName.notification,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state))
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          path: RouteName.page,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state))
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
          path: RouteName.user,
          pageBuilder: (context, state) =>
              _getPage(child: Error404Page(), state: state),
          routes: [
            GoRoute(
                path: RouteName.edit,
                pageBuilder: (context, state) =>
                    _getPage(child: Error404Page(), state: state))
          ])
    ]),
  ];

  static _getPage({required Widget child, required GoRouterState state}) {
    return MaterialPage(key: state.pageKey, child: child);
  }
}

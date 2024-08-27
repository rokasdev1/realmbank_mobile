import 'package:flutter/material.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:go_router/src/misc/extensions.dart';
import 'package:realmbank_mobile/main.dart';

extension IntX on int {
  Duration get days => Duration(days: this);
  Widget get heightBox => SizedBox(height: toDouble());
  Duration get hours => Duration(hours: this);
  Duration get minutes => Duration(minutes: this);
  Duration get months => Duration(days: this * 30);
  Duration get seconds => Duration(seconds: this);
  Widget get widthBox => SizedBox(width: toDouble());
}

extension ContextExtensions on BuildContext {
  void goRoute(RMRoute route) =>
      goNamed(route.name, pathParameters: route.params, extra: route.extra);

  void pushRoute(RMRoute route) => pushNamed(
        route.name,
        pathParameters: route.params,
        extra: route.extra,
      );

  Future<T?> showBottomSheet<T>(
    Widget Function(BuildContext) builder, {
    Color? backgroundColor = Colors.transparent,
    double? elevation = 0,
    bool isScrollControlled = true,
    Color? barrierColor,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      elevation: elevation,
      barrierColor: barrierColor,
    );
  }
}

extension RMRouteX on RMRoute {
  void go() {
    router.go(
      this,
    );
  }

  Future<T?> push<T>() {
    return router.push(
      this,
    );
  }
}

extension ThemeExtensions on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

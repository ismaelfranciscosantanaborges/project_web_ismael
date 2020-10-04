import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    Key key,
    @required this.mobile,
    @required this.desktop,
    this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    final _screenSizeW = MediaQuery.of(context).size.width;
    if (_screenSizeW < 800) return mobile;
    if (_screenSizeW < 1200) return tablet ?? mobile;
    return desktop;
  }
}

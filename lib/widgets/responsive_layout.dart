import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 600;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1000;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context) && desktop != null) return desktop!;
    if (isTablet(context) && tablet != null) return tablet!;
    return mobile;
  }
}

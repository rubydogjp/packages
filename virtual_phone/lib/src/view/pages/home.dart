import 'package:flutter/material.dart';

import '../router/locale_inherited.dart';
import '../router/navigator_shell.dart';
import '../widgets/side_menu_page.dart';
import 'menu_home.dart';
import 'device_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.app,
  });

  /// The previewed widget.
  final Widget app;

  /// Width
  static const _menuWidth = 320.0;

  static Locale? getLocale(BuildContext context) {
    final localeInheritedWidget =
        context.dependOnInheritedWidgetOfExactType<LocaleInherited>();
    return localeInheritedWidget?.locale;
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuPage(
      menuWidth: _menuWidth,
      menu: NavigatorShell(
        builder: (context) => const MenuHomePage(),
      ),
      content: DeviceContainerPage(
        app: app,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'color_palette.dart';

class FlutterThemeCreator {
  ThemeData create(BuildContext context) {
    final pallete = ColorPalette.of(context);

    return ThemeData(
      fontFamily: 'NotoSansJP',
      package: 'virtual_phone',
      primaryColor: pallete.activeButton,
      scaffoldBackgroundColor: pallete.background,
      cardColor: pallete.card,
      canvasColor: pallete.background,
      appBarTheme: AppBarTheme(
        backgroundColor: pallete.background,
        foregroundColor: pallete.strongText,
        elevation: 1.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: pallete.background,
        selectedItemColor: pallete.activeButton,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: pallete.strongText,
      ),
      iconTheme: IconThemeData(
        color: pallete.strongText,
      ),
    );
  }
}

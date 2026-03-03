import 'package:flutter/material.dart';

import '../theme/color_palette.dart';
import '../widgets/menu_header.dart';
import '../widgets/menu_header_separater.dart';
import '../widgets/menu_list.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = ColorPalette.of(context);

    return Drawer(
      backgroundColor: palette.card,
      surfaceTintColor: palette.card,
      child: const SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: MenuHeader(),
            ),
            MenuHeaderSeparater(),
            Expanded(
              child: MenuList(),
            ),
          ],
        ),
      ),
    );
  }
}

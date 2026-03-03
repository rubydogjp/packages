import 'package:flutter/material.dart';

import '../theme/color_palette.dart';
import 'menu_tile.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final pallete = ColorPalette.of(context);

    return Container(
      color: pallete.card,
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          MenuTile(
            icon: Icon(Icons.search, color: pallete.strongText),
            title: 'Search',
          ),
          const SizedBox(height: 30.0),
          MenuTile(
            icon: Icon(
              Icons.notifications_none,
              color: pallete.strongText,
            ),
            title: 'Notification',
          ),
          const SizedBox(height: 30.0),
          MenuTile(
            icon: Icon(
              Icons.mail_outline,
              color: pallete.strongText,
            ),
            title: 'Message',
          ),
          const SizedBox(height: 30.0),
          MenuTile(
            icon: Icon(
              Icons.bookmark_border,
              color: pallete.strongText,
            ),
            title: 'Bookmark',
          ),
          const SizedBox(height: 30.0),
          MenuTile(
            icon: Icon(
              Icons.person_outline,
              color: pallete.strongText,
            ),
            title: 'Profile',
          ),
        ],
      ),
    );
  }
}

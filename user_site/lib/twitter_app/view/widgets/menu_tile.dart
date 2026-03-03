import 'package:flutter/material.dart';

import '../theme/color_palette.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
  });

  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final pallete = ColorPalette.of(context);

    return Row(
      children: [
        icon,
        const SizedBox(width: 15.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: pallete.strongText,
          ),
        )
      ],
    );
  }
}

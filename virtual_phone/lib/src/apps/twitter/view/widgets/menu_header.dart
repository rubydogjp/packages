import 'package:flutter/material.dart';

import '../theme/color_palette.dart';
import 'user_icon.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pallete = ColorPalette.of(context);

    return Container(
      color: pallete.card,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            child: UserIcon(uri: 'assets/images/user-00.png'),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jackie',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: pallete.strongText,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                '@jackie',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: pallete.weakText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/color_palette.dart';
import 'user_icon.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final pallete = ColorPalette.of(context);

    return Container(
      color: pallete.card,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const UserIcon(uri: 'assets/images/user-00.png'),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Image.asset(
              package: 'virtual_phone',
              'assets/images/twitter.png',
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.settings_outlined,
                      color: pallete.strongText,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../temp/temp.dart';
import '../theme/color_palette.dart';

class TweetCreateButton extends StatelessWidget {
  const TweetCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final pallete = ColorPalette.of(context);

    return FloatingActionButton(
      onPressed: () {
        showTestDialog(context);
      },
      shape: const CircleBorder(),
      backgroundColor: pallete.activeButton,
      child: const Icon(Icons.add),
    );
  }
}

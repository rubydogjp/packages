import 'package:flutter/material.dart';

import '../theme/color_palette.dart';
import '../theme/flutter_theme.dart';
import '../widgets/home_header.dart';
import '../widgets/home_header_separater.dart';
import '../widgets/tweet_create_button.dart';
import 'menu.dart';
import 'timeline.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = ColorPalette.of(context);

    final themeCreator = FlutterThemeCreator();
    final theme = themeCreator.create(context);

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: palette.background,
        drawer: const MenuPage(),
        body: const SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: HomeHeader(),
              ),
              HomeHeaderSeparater(),
              Expanded(
                child: TimelinePage(),
              ),
            ],
          ),
        ),
        floatingActionButton: const TweetCreateButton(),
      ),
    );
  }
}

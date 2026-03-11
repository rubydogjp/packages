import 'package:flutter/material.dart';

import '../widgets/menu/control_device_section_header.dart';
import '../widgets/common/minimal_section_list.dart';
import '../widgets/menu/pick_locale_navigation_tile.dart';
import '../widgets/menu/pick_model_navigation_tile.dart';
import '../widgets/menu/pick_model_section_header.dart';
import '../widgets/common/section.dart';
import '../widgets/menu/settings_app_section_header.dart';
import '../widgets/menu/switch_bold_text_tile.dart';
import '../widgets/menu/switch_dark_mode_tile.dart';
import '../widgets/menu/switch_device_rotation_tile.dart';
import '../widgets/menu/switch_show_keyboard_tile.dart';
import '../widgets/menu/take_screenshot_tile.dart';
import '../widgets/menu/test_navigation_tile.dart';
import '../widgets/menu/test_section_header.dart';
import '../widgets/menu/text_scale_slider_tile.dart';

class MenuHomePage extends StatelessWidget {
  const MenuHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MinimalSectionList(
        sections: [
          // Pick Model
          StaticSection(
            header: PickModelSectionHeader(),
            tiles: [
              PickModelNavigationTile(),
            ],
          ),

          // Control Device
          StaticSection(
            header: ControlDeviceSectionHeader(),
            tiles: [
              SwitchDeviceRotationTile(),
              SwitchShowKeyboardTile(),
              TakeScreenshotTile(),
            ],
          ),

          // Settings App
          StaticSection(
            header: SettingsAppSectionHeader(),
            tiles: [
              PickLocaleNavigationTile(),
              SwitchDarkModeTile(),
              SwitchBoldTextTile(),
              TextScaleSliderTile(),
            ],
          ),

          // Test
          StaticSection(
            header: TestSectionHeader(),
            tiles: [
              TestNavigationTile(),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/os_settings.dart';
import '../common/minimal_tile.dart';

class SwitchDarkModeTile extends ConsumerWidget {
  const SwitchDarkModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(osSettingsProvider);
    final notifier = ref.watch(osSettingsProvider.notifier);

    return MinimalTile.onOff(
      title: const Text('ダークモード'),
      value: settings.isDarkMode,
      onChanged: (isOn) {
        notifier.toggleDarkMode();
      },
    );
  }
}

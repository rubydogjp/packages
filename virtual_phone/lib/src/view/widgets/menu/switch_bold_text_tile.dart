import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/os_settings.dart';
import '../common/minimal_tile.dart';

class SwitchBoldTextTile extends ConsumerWidget {
  const SwitchBoldTextTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(osSettingsProvider);
    final notifier = ref.watch(osSettingsProvider.notifier);

    return MinimalTile.onOff(
      title: const Text('文字を太くする'),
      value: settings.boldText,
      onChanged: (isOn) {
        notifier.toggleBoldText();
      },
    );
  }
}

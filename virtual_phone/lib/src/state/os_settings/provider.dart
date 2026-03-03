import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../external/locales/config.dart';
import '../../logic/os_settings/types/os_settings.dart';
import 'notifier.dart';

final osSettingsProvider = NotifierProvider<OSSettingsNotifier, OSSettings>(() {
  return OSSettingsNotifier();
});

final localeProvider = Provider((ref) {
  final locale = ref.watch(
    osSettingsProvider.select(
      (settings) => settings.locale,
    ),
  );
  return availableLocales
      .firstWhere(
        (it) => it.locale.toString() == locale,
        orElse: () => availableLocales.first,
      )
      .locale;
});

import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../external/locales/config.dart';
import '../external/locales/get_my_locale.dart';
import '../external/locales/models/named_locale.dart';
import '../logic/os_settings/os_settings.dart';

class OSSettingsNotifier extends Notifier<OSSettings> {
  @override
  OSSettings build() {
    final defaultLocale = getMyLocale(
      PlatformDispatcher.instance.views.first.platformDispatcher.locales,
      availableLocales.map((x) => x.locale).toList(),
    ).toString();

    return OSSettings(
      locale: defaultLocale,
      isDarkMode: false,
      boldText: false,
      disableAnimations: false,
      highContrast: false,
      accessibleNavigation: false,
      invertColors: false,
      textScale: 1.0,
    );
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void toggleAccessibleNavigation() {
    state = state.copyWith(accessibleNavigation: !state.accessibleNavigation);
  }

  void toggleInvertColors() {
    state = state.copyWith(invertColors: !state.invertColors);
  }

  void toggleBoldText() {
    state = state.copyWith(boldText: !state.boldText);
  }

  void setTextScale(double scale) {
    state = state.copyWith(textScale: scale);
  }

  void setLocale(NamedLocale locale) {
    state = state.copyWith(locale: locale.code);
  }
}

final osSettingsProvider = NotifierProvider<OSSettingsNotifier, OSSettings>(
  () => OSSettingsNotifier(),
);

final localeProvider = Provider((ref) {
  final locale = ref.watch(
    osSettingsProvider.select((settings) => settings.locale),
  );
  return availableLocales
      .firstWhere(
        (it) => it.locale.toString() == locale,
        orElse: () => availableLocales.first,
      )
      .locale;
});

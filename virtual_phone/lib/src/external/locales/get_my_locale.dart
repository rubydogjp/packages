import 'dart:collection';
import 'dart:ui';

Locale getMyLocale(
  List<Locale>? preferredLocales,
  Iterable<Locale> supportedLocales,
) {
  if (preferredLocales == null || preferredLocales.isEmpty) {
    return supportedLocales.first;
  }
  final Map<String, Locale> allSupportedLocales = HashMap<String, Locale>();
  final Map<String, Locale> languageAndCountryLocales =
      HashMap<String, Locale>();
  final Map<String, Locale> languageAndScriptLocales =
      HashMap<String, Locale>();
  final Map<String, Locale> languageLocales = HashMap<String, Locale>();
  final Map<String, Locale> countryLocales = HashMap<String, Locale>();
  for (final locale in supportedLocales) {
    allSupportedLocales[
            '${locale.languageCode}_${locale.scriptCode}_${locale.countryCode}'] ??=
        locale;
    languageAndScriptLocales['${locale.languageCode}_${locale.scriptCode}'] ??=
        locale;
    languageAndCountryLocales[
        '${locale.languageCode}_${locale.countryCode}'] ??= locale;
    languageLocales[locale.languageCode] ??= locale;
    if (locale.countryCode != null) {
      countryLocales[locale.countryCode!] ??= locale;
    }
  }

  Locale? matchesLanguageCode;
  Locale? matchesCountryCode;
  for (var localeIndex = 0;
      localeIndex < preferredLocales.length;
      localeIndex += 1) {
    final userLocale = preferredLocales[localeIndex];
    if (allSupportedLocales.containsKey(
      '${userLocale.languageCode}_${userLocale.scriptCode}_${userLocale.countryCode}',
    )) {
      return userLocale;
    }
    if (userLocale.scriptCode != null) {
      final match = languageAndScriptLocales[
          '${userLocale.languageCode}_${userLocale.scriptCode}'];
      if (match != null) {
        return match;
      }
    }
    if (userLocale.countryCode != null) {
      final match = languageAndCountryLocales[
          '${userLocale.languageCode}_${userLocale.countryCode}'];
      if (match != null) {
        return match;
      }
    }
    if (matchesLanguageCode != null) {
      return matchesLanguageCode;
    }
    var match = languageLocales[userLocale.languageCode];
    if (match != null) {
      matchesLanguageCode = match;
      if (localeIndex == 0 &&
          !(localeIndex + 1 < preferredLocales.length &&
              preferredLocales[localeIndex + 1].languageCode ==
                  userLocale.languageCode)) {
        return matchesLanguageCode;
      }
    }
    if (matchesCountryCode == null && userLocale.countryCode != null) {
      match = countryLocales[userLocale.countryCode];
      if (match != null) {
        matchesCountryCode = match;
      }
    }
  }
  final resolvedLocale =
      matchesLanguageCode ?? matchesCountryCode ?? supportedLocales.first;
  return resolvedLocale;
}

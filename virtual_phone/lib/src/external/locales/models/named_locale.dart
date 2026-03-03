import 'dart:ui';

class NamedLocale {
  const NamedLocale(
    this.code,
    this.name,
  );

  final String code;
  final String name;

  Locale get locale {
    final splits = code.split('_');

    final languageCode = splits.first;
    String? countryCode, scriptCode;
    if (splits.length > 2) {
      scriptCode = splits[1];
      countryCode = splits[2];
    } else if (splits.length > 1) {
      countryCode = splits[1];
    }

    return Locale.fromSubtags(
      countryCode: countryCode,
      languageCode: languageCode,
      scriptCode: scriptCode,
    );
  }

  @override
  String toString() => name;
}

import 'dart:math';

@Deprecated('Use [Nanoid] instead.')
typedef NanoID = Nanoid;

/// Nano ID generator.
class Nanoid {
  const Nanoid();

  /// Generate an ID using the standard URL-safe Base64 charset.
  ///
  /// [length]: Number of characters in the generated ID (default is 21).
  /// [prefix]: Optional prefix prepended to the generated ID.
  /// [excludedCharSet]: Characters to exclude from the default charset.
  String urlSafe({
    int length = 21,
    String prefix = '',
    String excludedCharSet = '',
  }) {
    return prefix +
        _generate(
          length: length,
          charSet: NanoidCharset.urlSafe,
          excludedCharSet: excludedCharSet,
        );
  }

  /// Generate an ID using a human-friendly URL-safe charset.
  ///
  /// Removes confusing characters:
  ///   - Uppercase: 'O', 'I'
  ///   - Lowercase: 'l'
  ///   - Digits: '0', '1'
  /// [length]: Number of characters in the generated ID (default is 21).
  /// [prefix]: Optional prefix prepended to the generated ID.
  /// [excludedCharSet]: Characters to exclude from the default charset.
  String urlSafeHumanFriendly({
    int length = 21,
    String prefix = '',
    String excludedCharSet = '',
  }) {
    return prefix +
        _generate(
          length: length,
          charSet: NanoidCharset.urlSafeHumanFriendly,
          excludedCharSet: excludedCharSet,
        );
  }

  /// Generate an ID using only digits (0-9).
  ///
  /// Useful for verification codes, PINs, and order numbers.
  /// [length]: Number of digits in the generated ID (default is 6).
  /// [prefix]: Optional prefix prepended to the generated ID.
  String numeric({int length = 6, String prefix = ''}) {
    return prefix +
        _generate(
          length: length,
          charSet: NanoidCharset.numeric,
          excludedCharSet: '',
        );
  }

  /// Generate an ID using hexadecimal characters (0-9, a-f).
  ///
  /// Useful for tokens, hashes, and color-code-style IDs.
  /// [length]: Number of characters in the generated ID (default is 32).
  /// [prefix]: Optional prefix prepended to the generated ID.
  String hex({int length = 32, String prefix = ''}) {
    return prefix +
        _generate(
          length: length,
          charSet: NanoidCharset.hex,
          excludedCharSet: '',
        );
  }

  /// Generate an ID using only lowercase letters and digits.
  ///
  /// Useful for slugs, DNS-safe names, and case-insensitive systems.
  /// [length]: Number of characters in the generated ID (default is 12).
  /// [prefix]: Optional prefix prepended to the generated ID.
  String lowercase({int length = 12, String prefix = ''}) {
    return prefix +
        _generate(
          length: length,
          charSet: NanoidCharset.lowercase,
          excludedCharSet: '',
        );
  }

  /// Generate an ID using letters and digits only (no symbols).
  ///
  /// [length]: Number of characters in the generated ID (default is 21).
  /// [prefix]: Optional prefix prepended to the generated ID.
  String alphanumeric({int length = 21, String prefix = ''}) {
    return prefix +
        _generate(
          length: length,
          charSet: NanoidCharset.alphanumeric,
          excludedCharSet: '',
        );
  }

  /// Generate an ID using a custom [charSet].
  ///
  /// [length]: Number of characters in the generated ID.
  /// [charSet]: String of characters from which to pick randomly.
  /// [prefix]: Optional prefix prepended to the generated ID.
  String custom({
    required int length,
    required String charSet,
    String prefix = '',
  }) {
    return prefix +
        _generate(length: length, charSet: charSet, excludedCharSet: '');
  }

  /// Core method to generate a random ID.
  ///
  /// Picks [length] characters randomly from [charSet] using
  /// a cryptographically secure random source.
  String _generate({
    required int length,
    required String charSet,
    required String excludedCharSet,
  }) {
    final effectiveCharSet =
        charSet.split('').where((c) => !excludedCharSet.contains(c)).join();

    if (effectiveCharSet.isEmpty) {
      throw ArgumentError('Character set is empty after exclusions.');
    }

    final random = Random.secure();
    final setLength = effectiveCharSet.length;
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      buffer.write(effectiveCharSet[random.nextInt(setLength)]);
    }
    return buffer.toString();
  }

  /// Calculate the entropy in bits for a given configuration.
  ///
  /// Higher entropy means more unique combinations and lower collision risk.
  /// For reference:
  ///   - UUID v4 has ~122 bits of entropy
  ///   - nanoid with default settings (length=21, charset=64) has ~126 bits
  ///
  /// [length]: Number of characters in the ID.
  /// [charsetSize]: Number of unique characters in the charset.
  static double entropy({required int length, required int charsetSize}) {
    if (charsetSize < 1) {
      throw ArgumentError('charsetSize must be at least 1.');
    }
    return length * (log(charsetSize) / ln2);
  }

  /// Estimate how long it would take for a 1% collision probability,
  /// given the ID configuration and generation rate.
  ///
  /// Returns the estimated duration until a 1% collision probability
  /// is reached at the given generation rate.
  ///
  /// Based on the birthday paradox approximation:
  ///   n ≈ sqrt(2 * S * p), where S = charsetSize^length, p = 0.01
  ///
  /// [length]: Number of characters in the ID.
  /// [charsetSize]: Number of unique characters in the charset.
  /// [idsPerHour]: Number of IDs generated per hour.
  static Duration collisionTime({
    required int length,
    required int charsetSize,
    required int idsPerHour,
  }) {
    if (charsetSize < 1 || idsPerHour < 1) {
      throw ArgumentError(
        'charsetSize and idsPerHour must be at least 1.',
      );
    }
    // Total possible IDs: charsetSize^length
    // Birthday paradox: n ≈ sqrt(2 * S * p) for probability p
    // Hours = n / idsPerHour
    final bitsOfEntropy = length * (log(charsetSize) / ln2);
    // Use log-space to avoid overflow: log(n) = 0.5 * (ln2*bits + ln(0.02))
    final logN = 0.5 * (bitsOfEntropy * ln2 + log(0.02));
    final logHours = logN - log(idsPerHour);

    // If logHours is huge, cap at a reasonable maximum
    if (logHours > 50) {
      // > 10^21 hours, practically infinite
      return const Duration(days: 365 * 1000000000); // 1 billion years
    }

    final hours = exp(logHours);
    return Duration(microseconds: (hours * Duration.microsecondsPerHour).round());
  }
}

/// Charset definitions for NanoID.
@Deprecated('Use [NanoidCharset] instead.')
typedef NanoIDCharset = NanoidCharset;

/// Charset definitions for Nanoid.
abstract class NanoidCharset {
  /// Standard URL-safe Base64 charset (64 characters).
  /// Includes letters, digits, '-' and '_'.
  static const String urlSafe =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';

  /// Human-friendly URL-safe charset.
  /// Removes characters that can be confused with others:
  ///   - 'O' (uppercase o), 'I' (uppercase i)
  ///   - 'l' (lowercase L)
  ///   - '0' (zero), '1' (one)
  static const String urlSafeHumanFriendly =
      'ABCDEFGHJKMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789-_';

  /// Digits only (10 characters).
  static const String numeric = '0123456789';

  /// Hexadecimal lowercase (16 characters).
  static const String hex = '0123456789abcdef';

  /// Lowercase letters and digits (36 characters).
  static const String lowercase =
      'abcdefghijklmnopqrstuvwxyz0123456789';

  /// Letters and digits, no symbols (62 characters).
  static const String alphanumeric =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
}

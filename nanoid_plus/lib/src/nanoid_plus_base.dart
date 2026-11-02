import 'dart:math';

@Deprecated('Use [Nanoid] instead.')
typedef NanoID = Nanoid;

/// Nano ID generator.
///
/// Every ID is `prefix + body`:
///
/// - `prefix` is prepended as is. It is not encoded or checked against the
///   charset, so only use characters your storage and URLs accept.
/// - `length` is the length of the random body and never counts the prefix:
///   `urlSafe(prefix: 'ord_', length: 21)` is 4 + 21 = 25 characters long.
///
/// When `length` is omitted, each method uses its own default:
///
/// | Method                   | Charset              | Default length |
/// |--------------------------|----------------------|----------------|
/// | [urlSafe]                | [NanoidCharset.urlSafe] (64)              | 21 |
/// | [urlSafeHumanFriendly]   | [NanoidCharset.urlSafeHumanFriendly] (56) | 21 |
/// | [alphanumeric]           | [NanoidCharset.alphanumeric] (62)         | 21 |
/// | [hex]                    | [NanoidCharset.hex] (16)                  | 32 |
/// | [lowercase]              | [NanoidCharset.lowercase] (36)            | 12 |
/// | [numeric]                | [NanoidCharset.numeric] (10)              | 6  |
///
/// The short defaults of [lowercase] and [numeric] suit codes, not database
/// keys. When IDs are generated in more than one place (e.g. several apps or
/// a server), pass the same `length` and charset everywhere instead of
/// relying on defaults, and check incoming IDs with [isValid].
///
/// Randomness: each character is picked with `random.nextInt(charset.length)`,
/// which is uniform for [Random.secure] (no modulo bias, on the VM and the
/// web alike). By default [Random.secure] is used; if the platform has no
/// secure source it throws an [UnsupportedError] instead of silently falling
/// back to a predictable one.
///
/// Invalid arguments throw an [ArgumentError] instead of producing a weaker
/// ID: a `length` below 1, a charset with fewer than 2 different characters,
/// duplicated characters, or characters outside the Basic Multilingual Plane
/// (such as emoji).
class Nanoid {
  /// Creates a generator.
  ///
  /// [random]: Source of randomness. Defaults to [Random.secure], which is
  /// what IDs that must be hard to guess need. Pass another source only on
  /// purpose: a platform's own cryptographic random, or a seeded `Random(42)`
  /// to get the same IDs on every run in tests or fixtures. A seeded or
  /// non-secure source makes every ID predictable, so never let one reach
  /// production for tokens, passwords, or public IDs.
  const Nanoid({this.random});

  /// Source of randomness, or `null` for [Random.secure].
  final Random? random;

  /// Collision times are capped to this value (100,000 years), which is
  /// "practically never" and still fits in a [Duration] on every platform.
  static const _maxCollisionTime = Duration(days: 365 * 100000);

  /// Generate an ID using the standard URL-safe Base64 charset.
  ///
  /// [length]: Number of random characters, not counting [prefix]
  /// (default is 21).
  /// [prefix]: Optional prefix prepended as is.
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
  /// [length]: Number of random characters, not counting [prefix]
  /// (default is 21).
  /// [prefix]: Optional prefix prepended as is.
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
  /// [length]: Number of random digits, not counting [prefix]
  /// (default is 6).
  /// [prefix]: Optional prefix prepended as is.
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
  /// [length]: Number of random characters, not counting [prefix]
  /// (default is 32).
  /// [prefix]: Optional prefix prepended as is.
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
  /// [length]: Number of random characters, not counting [prefix]
  /// (default is 12).
  /// [prefix]: Optional prefix prepended as is.
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
  /// [length]: Number of random characters, not counting [prefix]
  /// (default is 21).
  /// [prefix]: Optional prefix prepended as is.
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
  /// [length]: Number of random characters, not counting [prefix].
  /// [charSet]: Characters to pick from: at least 2, each only once, and no
  /// characters outside the Basic Multilingual Plane (such as emoji).
  /// [prefix]: Optional prefix prepended as is.
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
  /// Picks [length] characters uniformly from [charSet] (minus
  /// [excludedCharSet]) using [random], or [Random.secure] by default.
  String _generate({
    required int length,
    required String charSet,
    required String excludedCharSet,
  }) {
    if (length < 1) {
      throw ArgumentError.value(length, 'length', 'Must be at least 1');
    }
    _checkCharSet(charSet);

    final effectiveCharSet = charSet
        .split('')
        .where((c) => !excludedCharSet.contains(c))
        .join();

    if (effectiveCharSet.length < 2) {
      throw ArgumentError.value(
        excludedCharSet,
        'excludedCharSet',
        'Leaves fewer than 2 characters to pick from',
      );
    }

    final random = this.random ?? Random.secure();
    final setLength = effectiveCharSet.length;
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      buffer.write(effectiveCharSet[random.nextInt(setLength)]);
    }
    return buffer.toString();
  }

  /// Throws if [charSet] cannot give uniform, well-formed IDs.
  static void _checkCharSet(String charSet) {
    final units = charSet.codeUnits;
    // Surrogates are halves of characters such as emoji. Picking them one by
    // one would produce broken strings.
    if (units.any((u) => u >= 0xD800 && u <= 0xDFFF)) {
      throw ArgumentError.value(
        charSet,
        'charSet',
        'Must not contain characters outside the Basic Multilingual Plane '
            '(such as emoji)',
      );
    }
    // A duplicated character would be picked more often than the others.
    if (units.toSet().length != units.length) {
      throw ArgumentError.value(
        charSet,
        'charSet',
        'Must not contain the same character twice',
      );
    }
    if (units.length < 2) {
      throw ArgumentError.value(
        charSet,
        'charSet',
        'Must contain at least 2 characters',
      );
    }
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

  /// Whether [id] matches the given format exactly.
  ///
  /// Checks that [id] starts with [prefix], and that the rest is exactly
  /// [length] characters long (the prefix does not count) and made only of
  /// characters from [charSet].
  ///
  /// [charSet] and [length] have no defaults on purpose: pass the same values
  /// the IDs are generated with, so a mismatch between generators (e.g. a
  /// charset missing `-` and `_`, or a length that counts the prefix) is
  /// caught instead of hidden.
  ///
  /// Useful for rejecting malformed IDs from URLs or user input before
  /// looking them up.
  ///
  /// ```dart
  /// Nanoid.isValid(
  ///   'ord_V1StGXR8_Z5jdHi6B-myT',
  ///   charSet: NanoidCharset.urlSafe,
  ///   length: 21,
  ///   prefix: 'ord_',
  /// ); // true
  /// Nanoid.isValid('482937', charSet: NanoidCharset.numeric, length: 6);
  /// // true
  /// ```
  static bool isValid(
    String id, {
    required String charSet,
    required int length,
    String prefix = '',
  }) {
    if (!id.startsWith(prefix)) return false;
    final body = id.substring(prefix.length);
    if (body.length != length) return false;
    final allowed = charSet.codeUnits.toSet();
    return body.codeUnits.every(allowed.contains);
  }

  /// The shortest ID length that keeps the collision probability under 1%
  /// for [duration], when [idsPerHour] IDs are generated per hour.
  ///
  /// This is the inverse of [collisionTime]: use it to pick a length instead
  /// of trying lengths by hand.
  ///
  /// ```dart
  /// // 1,000 IDs per hour for 10 years, using the URL-safe charset
  /// Nanoid.requiredLength(
  ///   charsetSize: NanoidCharset.urlSafe.length,
  ///   idsPerHour: 1000,
  ///   duration: const Duration(days: 365 * 10),
  /// ); // 10
  /// ```
  ///
  /// [charsetSize]: Number of unique characters in the charset (at least 2).
  /// [idsPerHour]: Number of IDs generated per hour.
  /// [duration]: How long the IDs must stay unlikely to collide
  /// (at most 100,000 years).
  static int requiredLength({
    required int charsetSize,
    required int idsPerHour,
    required Duration duration,
  }) {
    if (charsetSize < 2) {
      throw ArgumentError('charsetSize must be at least 2.');
    }
    if (idsPerHour < 1) {
      throw ArgumentError('idsPerHour must be at least 1.');
    }
    if (duration <= Duration.zero || duration > _maxCollisionTime) {
      throw ArgumentError(
        'duration must be positive and at most 100,000 years.',
      );
    }

    bool lastsLongEnough(int length) =>
        collisionTime(
          length: length,
          charsetSize: charsetSize,
          idsPerHour: idsPerHour,
        ) >=
        duration;

    // n IDs over the duration stay under 1% while n <= sqrt(2 * S * 0.01),
    // that is S >= n^2 / 0.02, where S = charsetSize^length.
    final hours = duration.inMicroseconds / Duration.microsecondsPerHour;
    final logN = log(idsPerHour) + log(hours);
    final logS = 2 * logN - log(0.02);
    var length = max(1, (logS / log(charsetSize)).ceil());

    // Correct floating-point drift so the result agrees with collisionTime.
    while (!lastsLongEnough(length)) {
      length++;
    }
    while (length > 1 && lastsLongEnough(length - 1)) {
      length--;
    }
    return length;
  }

  /// Estimate how long it would take for a 1% collision probability,
  /// given the ID configuration and generation rate.
  ///
  /// Returns the estimated duration until a 1% collision probability
  /// is reached at the given generation rate, capped to 100,000 years.
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
      throw ArgumentError('charsetSize and idsPerHour must be at least 1.');
    }
    // Total possible IDs: charsetSize^length
    // Birthday paradox: n ≈ sqrt(2 * S * p) for probability p
    // Hours = n / idsPerHour
    final bitsOfEntropy = length * (log(charsetSize) / ln2);
    // Use log-space to avoid overflow: log(n) = 0.5 * (ln2*bits + ln(0.02))
    final logN = 0.5 * (bitsOfEntropy * ln2 + log(0.02));
    final logHours = logN - log(idsPerHour);

    // Cap huge values, which would not fit in a Duration.
    final maxHours = _maxCollisionTime.inHours;
    if (logHours >= log(maxHours)) {
      return _maxCollisionTime;
    }

    final hours = exp(logHours);
    return Duration(
      microseconds: (hours * Duration.microsecondsPerHour).round(),
    );
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
  static const String lowercase = 'abcdefghijklmnopqrstuvwxyz0123456789';

  /// Letters and digits, no symbols (62 characters).
  static const String alphanumeric =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
}

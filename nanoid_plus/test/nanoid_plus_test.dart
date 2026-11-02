import 'dart:math';

import 'package:nanoid_plus/nanoid_plus.dart';
import 'package:test/test.dart';

void main() {
  const nanoid = Nanoid();

  group('urlSafe', () {
    test('generates ID with default length 21', () {
      final id = nanoid.urlSafe();
      expect(id.length, 21);
    });

    test('generates ID with custom length', () {
      final id = nanoid.urlSafe(length: 10);
      expect(id.length, 10);
    });

    test('uses only URL-safe characters', () {
      final id = nanoid.urlSafe(length: 1000);
      expect(id, matches(RegExp(r'^[A-Za-z0-9_-]+$')));
    });

    test('supports prefix', () {
      final id = nanoid.urlSafe(prefix: 'usr_', length: 10);
      expect(id, startsWith('usr_'));
      expect(id.length, 14); // prefix (4) + id (10)
    });

    test('excludes characters', () {
      final id = nanoid.urlSafe(length: 500, excludedCharSet: 'ABC');
      expect(id, isNot(contains('A')));
      expect(id, isNot(contains('B')));
      expect(id, isNot(contains('C')));
    });

    test('generates unique IDs', () {
      final ids = List.generate(1000, (_) => nanoid.urlSafe());
      expect(ids.toSet().length, 1000);
    });
  });

  group('urlSafeHumanFriendly', () {
    test('excludes confusing characters', () {
      final id = nanoid.urlSafeHumanFriendly(length: 5000);
      expect(id, isNot(contains('O')));
      expect(id, isNot(contains('I')));
      expect(id, isNot(contains('l')));
      expect(id, isNot(contains('0')));
      expect(id, isNot(contains('1')));
    });

    test('supports prefix', () {
      final id = nanoid.urlSafeHumanFriendly(prefix: 'tk_');
      expect(id, startsWith('tk_'));
      expect(id.length, 24); // prefix (3) + id (21)
    });
  });

  group('numeric', () {
    test('generates digits only with default length 6', () {
      final id = nanoid.numeric();
      expect(id.length, 6);
      expect(id, matches(RegExp(r'^[0-9]+$')));
    });

    test('supports prefix', () {
      final id = nanoid.numeric(prefix: 'CODE-', length: 8);
      expect(id, startsWith('CODE-'));
      expect(id.length, 13);
      expect(id.substring(5), matches(RegExp(r'^[0-9]+$')));
    });
  });

  group('hex', () {
    test('generates hex with default length 32', () {
      final id = nanoid.hex();
      expect(id.length, 32);
      expect(id, matches(RegExp(r'^[0-9a-f]+$')));
    });
  });

  group('lowercase', () {
    test('generates lowercase alphanumeric with default length 12', () {
      final id = nanoid.lowercase();
      expect(id.length, 12);
      expect(id, matches(RegExp(r'^[a-z0-9]+$')));
    });
  });

  group('alphanumeric', () {
    test('generates alphanumeric with default length 21', () {
      final id = nanoid.alphanumeric();
      expect(id.length, 21);
      expect(id, matches(RegExp(r'^[A-Za-z0-9]+$')));
    });

    test('contains no symbols', () {
      final id = nanoid.alphanumeric(length: 5000);
      expect(id, isNot(contains('-')));
      expect(id, isNot(contains('_')));
    });
  });

  group('custom', () {
    test('uses only specified characters', () {
      final id = nanoid.custom(length: 100, charSet: 'abc');
      expect(id, matches(RegExp(r'^[abc]+$')));
    });

    test('supports prefix', () {
      final id = nanoid.custom(length: 5, charSet: '01', prefix: 'bin_');
      expect(id, startsWith('bin_'));
      expect(id.substring(4), matches(RegExp(r'^[01]+$')));
    });

    test('throws on empty charset', () {
      expect(() => nanoid.custom(length: 5, charSet: ''), throwsArgumentError);
    });
  });

  group('entropy', () {
    test('calculates correct entropy for base64', () {
      // 64 chars, length 21 → 21 * log2(64) = 21 * 6 = 126 bits
      final bits = Nanoid.entropy(length: 21, charsetSize: 64);
      expect(bits, closeTo(126.0, 0.01));
    });

    test('calculates correct entropy for numeric', () {
      // 10 chars, length 6 → 6 * log2(10) ≈ 6 * 3.3219 ≈ 19.93 bits
      final bits = Nanoid.entropy(length: 6, charsetSize: 10);
      expect(bits, closeTo(19.93, 0.01));
    });

    test('throws on invalid charset size', () {
      expect(
        () => Nanoid.entropy(length: 10, charsetSize: 0),
        throwsArgumentError,
      );
    });
  });

  group('collisionTime', () {
    test('returns longer duration for higher entropy', () {
      final short = Nanoid.collisionTime(
        length: 6,
        charsetSize: 10,
        idsPerHour: 1000,
      );
      final long = Nanoid.collisionTime(
        length: 21,
        charsetSize: 64,
        idsPerHour: 1000,
      );
      expect(long, greaterThan(short));
    });

    test('returns shorter duration for higher rate', () {
      final slow = Nanoid.collisionTime(
        length: 10,
        charsetSize: 36,
        idsPerHour: 10,
      );
      final fast = Nanoid.collisionTime(
        length: 10,
        charsetSize: 36,
        idsPerHour: 10000,
      );
      expect(slow, greaterThan(fast));
    });

    test('6-digit numeric code has short collision time', () {
      final duration = Nanoid.collisionTime(
        length: 6,
        charsetSize: 10,
        idsPerHour: 100,
      );
      // Should be on the order of minutes/hours, not years
      expect(duration.inDays, lessThan(365));
    });

    test('throws on invalid inputs', () {
      expect(
        () => Nanoid.collisionTime(length: 10, charsetSize: 0, idsPerHour: 100),
        throwsArgumentError,
      );
    });

    test('caps very high entropy instead of overflowing', () {
      // 192 bits at 1 ID/hour is far beyond what a Duration can hold.
      final duration = Nanoid.collisionTime(
        length: 32,
        charsetSize: 64,
        idsPerHour: 1,
      );
      expect(duration, const Duration(days: 365 * 100000));

      final lower = Nanoid.collisionTime(
        length: 16,
        charsetSize: 64,
        idsPerHour: 1,
      );
      expect(lower.isNegative, isFalse);
      expect(duration, greaterThanOrEqualTo(lower));
    });

    test('never decreases as the length grows', () {
      var previous = Duration.zero;
      for (var length = 1; length <= 40; length++) {
        final d = Nanoid.collisionTime(
          length: length,
          charsetSize: 64,
          idsPerHour: 1000,
        );
        expect(d, greaterThanOrEqualTo(previous), reason: 'length $length');
        previous = d;
      }
    });
  });

  group('NanoidCharset', () {
    test('urlSafe has 64 characters', () {
      expect(NanoidCharset.urlSafe.length, 64);
    });

    test('numeric has 10 characters', () {
      expect(NanoidCharset.numeric.length, 10);
    });

    test('hex has 16 characters', () {
      expect(NanoidCharset.hex.length, 16);
    });

    test('lowercase has 36 characters', () {
      expect(NanoidCharset.lowercase.length, 36);
    });

    test('alphanumeric has 62 characters', () {
      expect(NanoidCharset.alphanumeric.length, 62);
    });
  });

  group('random', () {
    test('a seeded source gives the same IDs every time', () {
      final a = Nanoid(random: Random(42));
      final b = Nanoid(random: Random(42));
      expect(
        List.generate(5, (_) => a.urlSafe()),
        List.generate(5, (_) => b.urlSafe()),
      );
    });

    test('different seeds give different IDs', () {
      final a = Nanoid(random: Random(1)).urlSafe();
      final b = Nanoid(random: Random(2)).urlSafe();
      expect(a, isNot(b));
    });

    test('applies to every generation method', () {
      String all(Nanoid n) => [
        n.urlSafe(),
        n.urlSafeHumanFriendly(),
        n.numeric(),
        n.hex(),
        n.lowercase(),
        n.alphanumeric(),
        n.custom(length: 8, charSet: 'abc'),
      ].join();
      expect(all(Nanoid(random: Random(7))), all(Nanoid(random: Random(7))));
    });

    test('defaults to the secure source', () {
      expect(const Nanoid().random, isNull);
      final ids = List.generate(100, (_) => const Nanoid().urlSafe());
      expect(ids.toSet().length, 100);
    });
  });

  group('isValid', () {
    const url = NanoidCharset.urlSafe;

    test('accepts generated IDs', () {
      for (var i = 0; i < 100; i++) {
        expect(
          Nanoid.isValid(nanoid.urlSafe(), charSet: url, length: 21),
          isTrue,
        );
        expect(
          Nanoid.isValid(
            nanoid.urlSafe(prefix: 'ord_'),
            charSet: url,
            length: 21,
            prefix: 'ord_',
          ),
          isTrue,
        );
        expect(
          Nanoid.isValid(
            nanoid.numeric(),
            charSet: NanoidCharset.numeric,
            length: 6,
          ),
          isTrue,
        );
        expect(
          Nanoid.isValid(
            nanoid.urlSafeHumanFriendly(length: 10),
            charSet: NanoidCharset.urlSafeHumanFriendly,
            length: 10,
          ),
          isTrue,
        );
      }
    });

    test('rejects characters outside the charset', () {
      expect(Nanoid.isValid('abc!def', charSet: url, length: 7), isFalse);
      expect(Nanoid.isValid('abc def', charSet: url, length: 7), isFalse);
      expect(
        Nanoid.isValid('12a4', charSet: NanoidCharset.numeric, length: 4),
        isFalse,
      );
      expect(
        Nanoid.isValid(
          'ABCD0',
          charSet: NanoidCharset.urlSafeHumanFriendly,
          length: 5,
        ),
        isFalse,
      );
    });

    test('catches a charset that differs between generators', () {
      // One side forgot '-' and '_' in its charset.
      const truncated = NanoidCharset.alphanumeric;
      final id = Nanoid(random: Random(3)).urlSafe(length: 200);
      expect(id, matches(RegExp('[-_]')));
      expect(Nanoid.isValid(id, charSet: truncated, length: 200), isFalse);
    });

    test('checks the exact length', () {
      expect(Nanoid.isValid('abcdef', charSet: url, length: 6), isTrue);
      expect(Nanoid.isValid('abcde', charSet: url, length: 6), isFalse);
      expect(Nanoid.isValid('abcdefg', charSet: url, length: 6), isFalse);
      expect(Nanoid.isValid('', charSet: url, length: 6), isFalse);
    });

    test('does not count the prefix toward the length', () {
      final id = nanoid.urlSafe(prefix: 'ord_', length: 21);
      expect(id.length, 25);
      expect(
        Nanoid.isValid(id, charSet: url, length: 21, prefix: 'ord_'),
        isTrue,
      );
      // A length that counts the prefix is a mismatch, not a match.
      expect(
        Nanoid.isValid(id, charSet: url, length: 25, prefix: 'ord_'),
        isFalse,
      );
    });

    test('checks the prefix', () {
      expect(
        Nanoid.isValid('usr_abc', charSet: url, length: 3, prefix: 'usr_'),
        isTrue,
      );
      expect(
        Nanoid.isValid('ord_abc', charSet: url, length: 3, prefix: 'usr_'),
        isFalse,
      );
      expect(
        Nanoid.isValid('abc', charSet: url, length: 3, prefix: 'usr_'),
        isFalse,
      );
    });
  });

  group('invalid arguments throw instead of weakening the ID', () {
    test('length below 1', () {
      expect(() => nanoid.urlSafe(length: 0), throwsArgumentError);
      expect(
        () => nanoid.urlSafe(length: -5, prefix: 'usr_'),
        throwsArgumentError,
      );
      expect(() => nanoid.numeric(length: 0), throwsArgumentError);
      expect(
        () => nanoid.custom(length: 0, charSet: 'ab'),
        throwsArgumentError,
      );
    });

    test('duplicated characters in a custom charset', () {
      expect(
        () => nanoid.custom(length: 10, charSet: 'aaaaaaaaab'),
        throwsArgumentError,
      );
    });

    test('characters outside the Basic Multilingual Plane', () {
      expect(
        () => nanoid.custom(length: 6, charSet: '😀🎉'),
        throwsArgumentError,
      );
    });

    test('a charset with fewer than 2 characters', () {
      expect(() => nanoid.custom(length: 5, charSet: 'a'), throwsArgumentError);
      expect(
        () =>
            nanoid.urlSafe(excludedCharSet: NanoidCharset.urlSafe.substring(1)),
        throwsArgumentError,
      );
    });

    test('valid edge cases still work', () {
      expect(
        nanoid.custom(length: 1, charSet: 'ab'),
        matches(RegExp(r'^[ab]$')),
      );
      expect(
        nanoid.urlSafe(excludedCharSet: NanoidCharset.urlSafe.substring(2)),
        matches(RegExp(r'^[AB]{21}$')),
      );
      // Excluding characters that are not in the charset is harmless.
      expect(nanoid.urlSafeHumanFriendly(excludedCharSet: 'O0Il1').length, 21);
    });
  });

  group('uniform distribution (no modulo bias)', () {
    // With a charset of 57, mapping a random byte with `% 57` would make the
    // first 28 characters 25% more frequent than the rest.
    final charSet = NanoidCharset.urlSafe.substring(0, 57);

    void expectUniform(Nanoid generator) {
      const perChar = 4000;
      final id = generator.custom(
        length: charSet.length * perChar,
        charSet: charSet,
      );
      final counts = <int, int>{};
      for (final unit in id.codeUnits) {
        counts[unit] = (counts[unit] ?? 0) + 1;
      }
      expect(counts.length, charSet.length);
      // About 7 standard deviations; a 25% bias would be 1000 off.
      for (final count in counts.values) {
        expect(count, inInclusiveRange(perChar - 450, perChar + 450));
      }
    }

    test('with the default secure source', () {
      expectUniform(const Nanoid());
    });

    test('with an injected source', () {
      expectUniform(Nanoid(random: Random(11)));
    });
  });

  group('requiredLength', () {
    test('is the inverse of collisionTime', () {
      const cases = [
        (charsetSize: 64, idsPerHour: 1000, days: 365 * 10),
        (charsetSize: 10, idsPerHour: 100, days: 1),
        (charsetSize: 36, idsPerHour: 1, days: 30),
        (charsetSize: 16, idsPerHour: 1000000, days: 365 * 100),
        (charsetSize: 2, idsPerHour: 5, days: 7),
      ];
      for (final c in cases) {
        final duration = Duration(days: c.days);
        final length = Nanoid.requiredLength(
          charsetSize: c.charsetSize,
          idsPerHour: c.idsPerHour,
          duration: duration,
        );
        Duration time(int length) => Nanoid.collisionTime(
          length: length,
          charsetSize: c.charsetSize,
          idsPerHour: c.idsPerHour,
        );
        expect(time(length), greaterThanOrEqualTo(duration), reason: '$c');
        if (length > 1) {
          expect(time(length - 1), lessThan(duration), reason: '$c');
        }
      }
    });

    test('matches the documented example', () {
      expect(
        Nanoid.requiredLength(
          charsetSize: NanoidCharset.urlSafe.length,
          idsPerHour: 1000,
          duration: const Duration(days: 365 * 10),
        ),
        10,
      );
    });

    test('grows with the rate and the duration', () {
      int length(int idsPerHour, int days) => Nanoid.requiredLength(
        charsetSize: 36,
        idsPerHour: idsPerHour,
        duration: Duration(days: days),
      );
      expect(length(1000, 365), greaterThan(length(10, 365)));
      expect(length(1000, 3650), greaterThanOrEqualTo(length(1000, 365)));
    });

    test('works up to the collisionTime cap', () {
      final length = Nanoid.requiredLength(
        charsetSize: 64,
        idsPerHour: 1,
        duration: const Duration(days: 365 * 100000),
      );
      expect(
        Nanoid.collisionTime(length: length, charsetSize: 64, idsPerHour: 1),
        const Duration(days: 365 * 100000),
      );
    });

    test('throws for invalid arguments', () {
      expect(
        () => Nanoid.requiredLength(
          charsetSize: 1,
          idsPerHour: 1,
          duration: const Duration(days: 1),
        ),
        throwsArgumentError,
      );
      expect(
        () => Nanoid.requiredLength(
          charsetSize: 64,
          idsPerHour: 0,
          duration: const Duration(days: 1),
        ),
        throwsArgumentError,
      );
      expect(
        () => Nanoid.requiredLength(
          charsetSize: 64,
          idsPerHour: 1,
          duration: Duration.zero,
        ),
        throwsArgumentError,
      );
      expect(
        () => Nanoid.requiredLength(
          charsetSize: 64,
          idsPerHour: 1,
          duration: const Duration(days: 365 * 100001),
        ),
        throwsArgumentError,
      );
    });
  });
}

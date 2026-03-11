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
      expect(
        () => nanoid.custom(length: 5, charSet: ''),
        throwsArgumentError,
      );
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
        () => Nanoid.collisionTime(
          length: 10,
          charsetSize: 0,
          idsPerHour: 100,
        ),
        throwsArgumentError,
      );
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
}

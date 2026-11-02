import 'dart:math';

import 'package:nanoid_plus/nanoid_plus.dart';

void main() {
  final nanoid = Nanoid();

  // --- Basic usage ---

  // URL-safe: A–Z, a–z, 0–9, '-', '_'
  print(nanoid.urlSafe()); // e.g. Axs0km54bhQzL9_YW1D0p

  // Human-friendly: removes O, I, l, 0, 1
  print(nanoid.urlSafeHumanFriendly(length: 12)); // e.g. jK7hV8vT3bN5

  // Custom charset
  print(nanoid.custom(length: 10, charSet: 'ABC123')); // e.g. A1B2C3A1B2

  // --- Prefix support ---
  // Stripe-style prefixed IDs for different resource types
  print(nanoid.urlSafe(prefix: 'usr_')); // e.g. usr_Axs0km54bhQzL9_YW1D0p
  print(nanoid.urlSafe(prefix: 'ord_', length: 12)); // e.g. ord_Zk3Pq1A9bX2m

  // --- Preset charsets ---

  // Verification codes, PINs
  print(nanoid.numeric()); // e.g. 482937 (6 digits by default)

  // Tokens, hash-style IDs
  print(nanoid.hex()); // e.g. a3f2b19c... (32 chars by default)

  // Slugs, DNS-safe names
  print(nanoid.lowercase()); // e.g. kxmfqzpwrtyb (12 chars by default)

  // No symbols, safe for any context
  print(nanoid.alphanumeric()); // e.g. Bk3mQz9pW1xR4nYs7jGtv

  // Presets also support prefix
  print(nanoid.numeric(prefix: 'CODE-', length: 8)); // e.g. CODE-48293716

  // --- Entropy & collision analysis ---

  // How many bits of entropy does the default nanoid have?
  final bits = Nanoid.entropy(length: 21, charsetSize: 64);
  print(
    'Default nanoid entropy: ${bits.toStringAsFixed(1)} bits',
  ); // 126.0 bits

  // How long until 1% collision probability at 1000 IDs/hour?
  final duration = Nanoid.collisionTime(
    length: 21,
    charsetSize: 64,
    idsPerHour: 1000,
  );
  print('Time to 1% collision risk: ${duration.inDays ~/ 365} years');

  // Compare: a 6-digit numeric code at 100 IDs/hour
  final pinDuration = Nanoid.collisionTime(
    length: 6,
    charsetSize: 10,
    idsPerHour: 100,
  );
  print('6-digit PIN collision risk: ${pinDuration.inMinutes} minutes');

  // --- Validation ---

  // Reject malformed IDs from URLs or user input before a lookup.
  // Pass the same charset and length the IDs are generated with
  // (the length never counts the prefix).
  print(
    Nanoid.isValid(
      'usr_V1StGXR8_Z5jdHi6B-myT',
      charSet: NanoidCharset.urlSafe,
      length: 21,
      prefix: 'usr_',
    ),
  );
  // true
  print(Nanoid.isValid('48a937', charSet: NanoidCharset.numeric, length: 6));
  // false

  // --- Choosing a length ---

  // Shortest length that stays under 1% collision risk for 10 years
  // at 1000 IDs/hour
  final length = Nanoid.requiredLength(
    charsetSize: NanoidCharset.urlSafe.length,
    idsPerHour: 1000,
    duration: const Duration(days: 365 * 10),
  );
  print('Required length: $length'); // 10

  // --- Reproducible IDs ---

  // A seeded source gives the same IDs on every run (e.g. in tests).
  // Keep the default secure source for anything that must be unguessable.
  final seeded = Nanoid(random: Random(42));
  print(seeded.urlSafe(length: 8)); // same output every run
}

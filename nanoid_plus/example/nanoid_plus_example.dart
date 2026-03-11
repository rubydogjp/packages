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
  print('Default nanoid entropy: ${bits.toStringAsFixed(1)} bits'); // 126.0 bits

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
}

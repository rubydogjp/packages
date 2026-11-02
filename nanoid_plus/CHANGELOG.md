## 2.1.0

- **New**: `Nanoid(random: ...)` to use another source of randomness, e.g. a seeded `Random` for reproducible IDs in tests (defaults to `Random.secure()`)
- **New**: `Nanoid.isValid()` checks that a string matches a charset, length, and prefix. `charSet` and `length` are required, so a mismatch between generators is caught instead of hidden by a default
- **New**: `Nanoid.requiredLength()` returns the shortest length that keeps the collision risk under 1% for a given rate and duration (the inverse of `collisionTime()`)
- **Behavior change**: invalid arguments now throw an `ArgumentError` instead of silently producing a weaker ID: a `length` below 1 (returned an empty ID), a charset with duplicated characters (biased the output), characters outside the Basic Multilingual Plane such as emoji (produced broken strings), or fewer than 2 characters left to pick from
- **Docs**: state that `length` never counts the prefix, that the prefix is prepended as is, each method's default length, and that randomness is uniform (no modulo bias) and never falls back to a non-secure source
- **Fix**: `Nanoid.collisionTime()` returned a negative duration for very high entropy (its 1 billion year cap overflowed `Duration`). It is now capped to 100,000 years
- Bump `test` to 1.33.0

## 2.0.2

- Require Dart 3.13.0
- Bump `test` to 1.32.0, `lints` to 6.1.0

## 2.0.1

- Require Dart 3.12.0
- Bump `test` to 1.31.1

## 2.0.0

- **New**: Preset generation methods: `numeric()`, `hex()`, `lowercase()`, `alphanumeric()`
- **New**: Prefix support on all methods (Stripe-style IDs)
- **New**: `NanoidCharset` with predefined character sets
- **New**: `Nanoid.entropy()` for entropy calculation
- **New**: `Nanoid.collisionTime()` for collision probability estimation
- **New**: Comprehensive test suite
- Require Dart 3.11.0

## 1.8.0

- [docs] give up Language anchors

## 1.7.0

- [docs] fix Language anchors

## 1.6.0

- [docs] fix Language anchors

## 1.5.0

- [docs] fix Language anchors

## 1.4.0

- [docs] fix features list

## 1.3.0

- [FIX] `NanoID` is now deprecated.
- [NEW] **`Nanoid`** is introduced.

## 1.2.0

- [deps] Require Dart 3.9.0

## 1.1.0

- [NEW] excludedCharSet

## 1.0.1

- [docs] fix example code

## 1.0.0

- Initial Release

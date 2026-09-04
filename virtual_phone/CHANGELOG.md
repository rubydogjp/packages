## 2.0.2

- Upgrade to `freezed` ^4.0.1 and regenerate (code generation only; no public API change)
- Bump `build_runner` to ^2.16.1, `json_serializable` to ^6.14.1, `uuid` to ^4.6.0
- Require Flutter 3.47.2 / Dart 3.13.0

## 2.0.1

- Upgrade to `flutter_riverpod` ^3.0.0 (internal implementation; no public API change)
- Bump `flutter_lints` to ^6.0.0, `build_runner` to ^2.15.0, `json_serializable` to ^6.14.0, `json_annotation` to ^4.12.0
- Complete freezed 3 migration for `DeviceState` and `OSSettings`
- Require Flutter 3.44.1 / Dart 3.12.0

## 2.0.0

- Fix non-uniform scaling across different virtual devices
- Fix frame/screen alignment with AspectRatio
- Refactor type names for clarity (BezelRatio, EdgeInset, DeviceSafeArea)
- Consolidate device model types into single file
- Reorganize state files by domain
- Reorganize widgets into categorized subdirectories
- Simplify MediaQuery override logic
- Require Flutter 3.41.2 / Dart 3.11.0

## 1.0.0

- Initial Release

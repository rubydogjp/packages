import '../../types/index.dart';

final iphone14 = DeviceModel(
  id: PresetModel.iphone14.id,
  label: const ModelLabel(
    name: 'iPhone 14',
    releasedYear: 2022,
  ),
  hardwareImageUri: 'assets/images/iphone-14.png',
  hardwareScreen: const HardwareScreen(
    position: RatioPosition(
      left: 0.0595,
      top: 0.0220,
      right: 0.0550,
      bottom: 0.0225,
    ),
    logicalWidth: 390,
    logicalHeight: 844,
    logicalCornerRadius: 30,
    pixelRatio: 3,
    safeAreaInset: HardwareSafeAreaInset(
      portrait: HardwareInset(
        left: 0,
        top: 30,
        right: 0,
        bottom: 30,
      ),
      landscape: HardwareInset(
        left: 30,
        top: 0,
        right: 30,
        bottom: 0,
      ),
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.ios,
    keyboardHeight: 238,
  ),
);

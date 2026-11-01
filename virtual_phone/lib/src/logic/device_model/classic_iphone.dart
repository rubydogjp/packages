import 'device_model.dart';

final classicIphone = DeviceModel(
  id: PresetModel.classicIphone.id,
  label: const ModelLabel(
    name: '初代 iPhone',
    releasedYear: 2007,
  ),
  hardwareImageUri: 'assets/images/classic-iphone.png',
  hardwareScreen: const HardwareScreen(
    bezelRatio: BezelRatio(
      left: 0.098148,
      top: 0.172925,
      right: 0.087037,
      bottom: 0.174901,
    ),
    logicalWidth: 320,
    logicalHeight: 480,
    logicalCornerRadius: 0,
    pixelRatio: 1,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset.zero,
      landscape: EdgeInset.zero,
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.ios,
    keyboardHeight: 238,
  ),
);

import 'device_model.dart';

final pixel = DeviceModel(
  id: PresetModel.pixel.id,
  label: const ModelLabel(
    name: '初代 Pixel',
    releasedYear: 2016,
  ),
  hardwareImageUri: 'assets/images/pixel.png',
  hardwareScreen: const HardwareScreen(
    bezelRatio: BezelRatio(
      left: 0.061522,
      top: 0.114611,
      right: 0.070858,
      bottom: 0.129512,
    ),
    logicalWidth: 411.4286,
    logicalHeight: 731.4286,
    logicalCornerRadius: 0,
    pixelRatio: 2.625,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset.zero,
      landscape: EdgeInset.zero,
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.android,
    keyboardHeight: 238,
  ),
);

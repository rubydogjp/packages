import 'device_model.dart';

final nexusOne = DeviceModel(
  id: PresetModel.nexusOne.id,
  label: const ModelLabel(
    name: 'Nexus One',
    releasedYear: 2010,
  ),
  hardwareImageUri: 'assets/images/nexus-one.png',
  hardwareScreen: const HardwareScreen(
    bezelRatio: BezelRatio(
      left: 0.083673,
      top: 0.109856,
      right: 0.083673,
      bottom: 0.191992,
    ),
    logicalWidth: 320,
    logicalHeight: 533.3333,
    logicalCornerRadius: 0,
    pixelRatio: 1.5,
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

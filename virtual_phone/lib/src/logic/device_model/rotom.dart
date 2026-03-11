import 'device_model.dart';

final rotom = DeviceModel(
  id: PresetModel.rotom.id,
  label: const ModelLabel(
    name: 'ロトム',
    releasedYear: 2019,
  ),
  hardwareImageUri: 'assets/images/rotom.png',
  hardwareScreen: const HardwareScreen(
    bezelRatio: BezelRatio(
      left: 0.0538,
      top: 0.2220,
      right: 0.0456,
      bottom: 0.1256,
    ),
    logicalWidth: 432,
    logicalHeight: 850,
    logicalCornerRadius: 24,
    pixelRatio: 3,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset(
        left: 0,
        top: 60,
        right: 0,
        bottom: 24,
      ),
      landscape: EdgeInset(
        left: 60,
        top: 0,
        right: 24,
        bottom: 0,
      ),
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.fantasy,
    keyboardHeight: 238,
  ),
);

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
      left: 0.18394,
      top: 0.02663,
      right: 0.328665,
      bottom: 0.02663,
    ),
    logicalWidth: 432,
    logicalHeight: 853.2414,
    logicalCornerRadius: 30.62,
    pixelRatio: 3,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset(
        left: 0,
        top: 58.76,
        right: 0,
        bottom: 30.62,
      ),
      landscape: EdgeInset(
        left: 58.76,
        top: 0,
        right: 30.62,
        bottom: 0,
      ),
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.fantasy,
    keyboardHeight: 238,
  ),
);

import 'device_model.dart';

final iphone14 = DeviceModel(
  id: PresetModel.iphone14.id,
  label: const ModelLabel(
    name: 'iPhone 14',
    releasedYear: 2022,
  ),
  hardwareImageUri: 'assets/images/iphone-14.png',
  hardwareScreen: const HardwareScreen(
    bezelRatio: BezelRatio(
      left: 0.0595,
      top: 0.0220,
      right: 0.0550,
      bottom: 0.0225,
    ),
    logicalWidth: 390,
    logicalHeight: 844,
    logicalCornerRadius: 30,
    pixelRatio: 3,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset(
        left: 0,
        top: 30,
        right: 0,
        bottom: 30,
      ),
      landscape: EdgeInset(
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

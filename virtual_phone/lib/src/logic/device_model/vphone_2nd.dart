import 'device_model.dart';

final vphone2nd = DeviceModel(
  id: PresetModel.vphone2nd.id,
  label: const ModelLabel(
    name: '第二世代 vPhone',
    releasedYear: 2026,
  ),
  hardwareImageUri: 'assets/images/vphone-2nd.png',
  hardwareScreen: const HardwareScreen(
    bezelRatio: BezelRatio(
      left: 0.049756,
      top: 0.026686,
      right: 0.049756,
      bottom: 0.026686,
    ),
    logicalWidth: 400,
    logicalHeight: 784,
    logicalCornerRadius: 54.13,
    pixelRatio: 3,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset(
        left: 0,
        top: 54.13,
        right: 0,
        bottom: 54.13,
      ),
      landscape: EdgeInset(
        left: 54.13,
        top: 0,
        right: 54.13,
        bottom: 0,
      ),
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.fantasy,
    keyboardHeight: 238,
  ),
);

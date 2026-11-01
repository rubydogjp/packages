import 'device_model.dart';

final vphoneOriginal = DeviceModel(
  id: PresetModel.vphoneOriginal.id,
  label: const ModelLabel(
    name: '初代 vPhone',
    releasedYear: 2026,
  ),
  hardwareImageUri: 'assets/images/vphone-original.png',
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
    pixelRatio: 2,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset.zero,
      landscape: EdgeInset.zero,
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.fantasy,
    keyboardHeight: 238,
  ),
);

import 'device_model.dart';

final classicAndroid = DeviceModel(
  id: PresetModel.classicAndroid.id,
  label: const ModelLabel(
    name: '初代 Android',
    releasedYear: 2008,
  ),
  hardwareImageUri: 'assets/images/classic-android.png',
  hardwareScreen: const HardwareScreen(
    bezelRatio: BezelRatio(
      left: 0.481499,
      top: 0.105429,
      right: 0.044118,
      bottom: 0.304485,
    ),
    logicalWidth: 320,
    logicalHeight: 480,
    logicalCornerRadius: 8.96,
    pixelRatio: 1,
    safeArea: DeviceSafeArea(
      portrait: EdgeInset(
        left: 0,
        top: 8.96,
        right: 0,
        bottom: 8.96,
      ),
      landscape: EdgeInset(
        left: 8.96,
        top: 0,
        right: 8.96,
        bottom: 0,
      ),
    ),
  ),
  os: const SoftwareOS(
    platform: SoftwarePlatform.android,
    keyboardHeight: 238,
  ),
);

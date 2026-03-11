// All device model types consolidated into a single file.

// --- Geometry types ---

class EdgeInset {
  const EdgeInset({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  static const zero = EdgeInset(left: 0, top: 0, right: 0, bottom: 0);

  final double left;
  final double top;
  final double right;
  final double bottom;
}

class BezelRatio {
  const BezelRatio({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  final double left;
  final double top;
  final double right;
  final double bottom;
}

class DeviceSafeArea {
  const DeviceSafeArea({
    required this.portrait,
    required this.landscape,
  });

  final EdgeInset portrait;
  final EdgeInset landscape;
}

// --- Platform & OS ---

enum SoftwarePlatform {
  ios,
  android,
  fantasy,
}

class SoftwareOS {
  const SoftwareOS({
    required this.platform,
    required this.keyboardHeight,
  });

  final SoftwarePlatform platform;
  final double keyboardHeight;
}

// --- Screen ---

class HardwareScreen {
  const HardwareScreen({
    required this.bezelRatio,
    required this.logicalWidth,
    required this.logicalHeight,
    required this.logicalCornerRadius,
    required this.pixelRatio,
    required this.safeArea,
  });

  final BezelRatio bezelRatio;
  final double logicalWidth;
  final double logicalHeight;
  final double logicalCornerRadius;
  final double pixelRatio;
  final DeviceSafeArea safeArea;
}

class SoftwareScreen {
  const SoftwareScreen({
    required this.width,
    required this.height,
    required this.cornerRadius,
    required this.safeAreaInset,
  });

  final double width;
  final double height;
  final double cornerRadius;
  final EdgeInset safeAreaInset;
}

// --- Model ---

class ModelLabel {
  const ModelLabel({
    required this.name,
    required this.releasedYear,
  });

  final String name;
  final int releasedYear;
}

enum PresetModel {
  /// iPhone (classic) - Apple iPhone 2007
  classicIphone('classic-iphone'),

  /// Android (classic) - T-Mobile G1 2008
  classicAndroid('classic-android'),

  /// vPhone
  vphone('vphone'),

  /// vPhone (small)
  vphoneSmall('vphone-small'),

  /// vPhone (large)
  vphoneLarge('vphone-large'),

  /// rotom
  rotom('rotom'),

  /* 2022 */

  iphone14('iphone-14'),
  iphoneSE3('iphone-se-3rd'),
  galaxyS22('galaxy-s22');

  const PresetModel(this.id);
  final String id;
}

class DeviceModel {
  const DeviceModel({
    required this.id,
    required this.label,
    required this.hardwareImageUri,
    required this.hardwareScreen,
    required this.os,
  });

  final String id;
  final ModelLabel label;
  final String hardwareImageUri;
  final HardwareScreen hardwareScreen;
  final SoftwareOS os;
}

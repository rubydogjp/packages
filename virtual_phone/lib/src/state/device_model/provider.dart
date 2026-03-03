import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/device_model/config/preset_models.dart';
import 'initial_model_id.dart';
import 'notifier.dart';

final initialModelIdProvider =
    AsyncNotifierProvider<InitialModelIdNotifier, String>(
  () {
    return InitialModelIdNotifier();
  },
);

final deviceModelIdProvider =
    AsyncNotifierProvider<DeviceModelIdNotifier, String>(
  () {
    return DeviceModelIdNotifier();
  },
);

final deviceModelProvider = Provider(
  (ref) {
    final modelId = ref.watch(deviceModelIdProvider);
    if (!modelId.hasValue) return null;
    return presetModels.firstWhere(
      (it) => it.id == modelId.value!,
    );
  },
);

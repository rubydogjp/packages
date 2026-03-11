import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/device_model/presets.dart';

class InitialModelIdNotifier extends AsyncNotifier<String> {
  final completer = Completer<String>();

  @override
  Future<String> build() async {
    return completer.future;
  }

  void initialize(String modelId) {
    if (completer.isCompleted) return;
    completer.complete(modelId);
  }
}

class DeviceModelIdNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final initialModelId = await ref.read(initialModelIdProvider.future);
    return initialModelId;
  }

  void setId(String id) {
    state = AsyncValue.data(id);
  }
}

final initialModelIdProvider =
    AsyncNotifierProvider<InitialModelIdNotifier, String>(
  () => InitialModelIdNotifier(),
);

final deviceModelIdProvider =
    AsyncNotifierProvider<DeviceModelIdNotifier, String>(
  () => DeviceModelIdNotifier(),
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

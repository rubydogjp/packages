import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';

class DeviceModelIdNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final initialModelId = await ref.read(initialModelIdProvider.future);
    return initialModelId;
  }

  /// Select the current device.
  void setId(String id) {
    state = AsyncValue.data(id);
  }
}

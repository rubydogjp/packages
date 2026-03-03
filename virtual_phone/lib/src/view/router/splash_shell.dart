import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_phone/src/state/device_model/provider.dart';
import 'package:virtual_phone/src/view/widgets/on_appear.dart';

import '../../logic/config/types/config.dart';
import '../../logic/device_model/types/index.dart';
import 'config_inherited.dart';

class SplashShell extends ConsumerWidget {
  const SplashShell({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialModelId = ref.watch(initialModelIdProvider);

    if (initialModelId.isLoading) {
      return MaterialApp(
        home: Scaffold(
          body: OnAppear(
            onAppear: () {
              final notifier = ref.read(initialModelIdProvider.notifier);
              final configInherited =
                  context.dependOnInheritedWidgetOfExactType<ConfigInherited>();
              final config = configInherited?.config ?? _defaultConfig;
              final initialModelId =
                  config.initialModelId ?? PresetModel.values.first.id;
              notifier.initialize(initialModelId);
            },
            child: const Center(
              child: Text('Now Initializing...'),
            ),
          ),
        ),
      );
    }

    if (initialModelId.hasError) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Oops. Something went wrong.'),
          ),
        ),
      );
    }

    return builder(context);
  }
}

final _defaultConfig = Config(
  initialModelId: PresetModel.classicIphone.id,
);

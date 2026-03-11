import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/minimal_tile.dart';
import '../testing/test_page.dart';

class TestNavigationTile extends ConsumerWidget {
  const TestNavigationTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MinimalTile.navigation(
      title: const Text('自動テスト (ベータ版)'),
      builder: (context) => const TestPage(),
    );
  }
}

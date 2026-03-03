import 'package:flutter/material.dart';
import 'package:virtual_phone/src/view/widgets/minimal_page.dart';

import '../pages/action_list.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MinimalPage(
      title: '自動テスト (ベータ版)',
      body: ActionListPage(),
    );
  }
}

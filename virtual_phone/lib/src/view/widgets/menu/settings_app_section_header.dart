import 'package:flutter/material.dart';
import '../common/minimal_section_header.dart';

class SettingsAppSectionHeader extends StatelessWidget {
  const SettingsAppSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MinimalSectionHeader(
      title: '設定アプリ',
    );
  }
}

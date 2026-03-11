import 'package:flutter/material.dart';
import '../common/minimal_section_header.dart';

class ControlDeviceSectionHeader extends StatelessWidget {
  const ControlDeviceSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MinimalSectionHeader(
      title: '操作する',
    );
  }
}

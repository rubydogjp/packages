import 'package:flutter/material.dart';
import '../common/minimal_section_header.dart';

class PickLocaleSectionHeader extends StatelessWidget {
  const PickLocaleSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MinimalSectionHeader(
      title: '言語と地域',
    );
  }
}

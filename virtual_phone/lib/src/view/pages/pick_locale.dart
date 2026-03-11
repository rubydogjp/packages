import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';
import 'package:virtual_phone/src/view/widgets/common/minimal_page.dart';
import 'package:virtual_phone/src/view/widgets/common/minimal_section_header.dart';
import 'package:virtual_phone/src/view/widgets/common/minimal_section_list.dart';
import 'package:virtual_phone/src/view/widgets/menu/pick_locale_tile.dart';
import 'package:virtual_phone/src/view/widgets/common/section.dart';

import '../../external/locales/config.dart';
import '../../external/locales/models/named_locale.dart';
import '../widgets/common/minimal_text_field.dart';

class PickLocalePage extends HookWidget {
  const PickLocalePage({
    super.key,
    required this.locale,
    required this.onSelected,
  });

  final NamedLocale locale;
  final void Function(NamedLocale locale) onSelected;

  @override
  Widget build(BuildContext context) {
    final filterString = useState('');

    final filteredLocales = availableLocales.where(
      (it) {
        final filter = filterString.value.trim().toLowerCase();
        final matchName = it.name.toLowerCase().contains(filter);
        final matchCode = it.code.toLowerCase().contains(filter);
        return filter.isEmpty || matchName || matchCode;
      },
    );

    return MinimalPage(
      title: '言語と地域',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: MinimalTextField(
              hintText: 'Search by locale name or code',
              text: filterString.value,
              onChanged: (newText) {
                final custom = newText.replaceAll(' ', '').toLowerCase();
                filterString.value = custom;
              },
            ),
          ),
          Expanded(
            child: MinimalSectionList(
              sections: [
                DynamicSection(
                  header: const MinimalSectionHeader(title: '言語と地域'),
                  tileCount: filteredLocales.length,
                  tileBuilder: (index) => PickLocaleTile(
                    locale: filteredLocales.toList()[index],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../logic/device_model/device_model.dart';
import '../widgets/menu/classic_model_section_header.dart';
import '../widgets/menu/fantasy_model_section_header.dart';
import '../widgets/common/minimal_page.dart';
import '../widgets/common/section.dart';
import '../widgets/common/minimal_section_list.dart';
import '../widgets/menu/pick_model_tile.dart';
import '../widgets/menu/standard_model_section_header.dart';

class PickModelPage extends StatelessWidget {
  const PickModelPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MinimalPage(
      title: '機種',
      body: MinimalSectionList(
        sections: [
          StaticSection(
            header: const ClassicModelSectionHeader(),
            tiles: [
              PickModelTile(
                modelId: PresetModel.classicIphone.id,
              ),
              PickModelTile(
                modelId: PresetModel.classicAndroid.id,
              ),
            ],
          ),
          StaticSection(
            header: const FantasyModelSectionHeader(),
            tiles: [
              PickModelTile(
                modelId: PresetModel.rotom.id,
              ),
            ],
          ),
          StaticSection(
            header: const StandardModelSectionHeader(),
            tiles: [
              PickModelTile(
                modelId: PresetModel.iphone14.id,
              ),
              // PickModelTile(
              //   modelId: PresetModel.galaxyS22.id,
              // ),
              // PickModelTile(
              //   modelId: PresetModel.iphoneSE3.id,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

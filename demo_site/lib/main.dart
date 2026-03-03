import 'package:flutter/material.dart';
import 'package:virtual_phone/virtual_phone.dart';

import 'view/router/demo_os.dart';

final config = VirtualPhoneConfig(
  initialModelId: VirtualPhonePresetModel.iphone14.id,
);

void main() {
  runApp(
    VirtualPhoneScope(
      config: config,
      child: const DemoOS(),
    ),
  );
}

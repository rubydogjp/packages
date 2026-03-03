import 'package:flutter/material.dart';
import 'package:virtual_phone/virtual_phone.dart';

import '../pages/home.dart';

class DemoOS extends StatelessWidget {
  const DemoOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Phone',
      locale: VirtualPhone.locale(context),
      builder: VirtualPhone.builder,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

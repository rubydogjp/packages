import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_phone/virtual_phone.dart';

void main() {
  // Tests run outside the web, where the simulator is turned off.
  testWidgets('shows the app as is outside the web', (tester) async {
    await tester.pumpWidget(
      VirtualPhoneScope(
        child: Builder(
          builder: (context) => MaterialApp(
            locale: VirtualPhone.locale(context),
            builder: VirtualPhone.builder,
            home: const Text('my app'),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('my app'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_phone/src/logic/config.dart';
import 'package:virtual_phone/src/logic/device_model/device_model.dart';
import 'package:virtual_phone/src/view/pages/home.dart';
import 'package:virtual_phone/src/view/router/config_inherited.dart';
import 'package:virtual_phone/src/view/router/splash_shell.dart';
import 'package:virtual_phone/src/view/widgets/common/side_menu_page.dart';

void setViewSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

/// Content whose state should survive layout changes.
class _Counter extends StatefulWidget {
  const _Counter();

  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => setState(() => count++),
        child: Text('count $count'),
      ),
    );
  }
}

Widget sideMenuPage() {
  return const MaterialApp(
    home: SideMenuPage(
      menuWidth: 320,
      menu: ColoredBox(
        color: Colors.white,
        child: Center(child: Text('menu item')),
      ),
      content: _Counter(),
    ),
  );
}

void main() {
  group('SideMenuPage', () {
    testWidgets('pins the menu next to the content on wide screens', (
      tester,
    ) async {
      setViewSize(tester, const Size(1280, 800));
      await tester.pumpWidget(sideMenuPage());

      expect(find.text('メニュー'), findsNothing);
      expect(find.text('menu item').hitTestable(), findsOneWidget);
      expect(tester.getTopLeft(find.byType(_Counter)).dx, 320);
    });

    testWidgets('gives the content the whole width on narrow screens', (
      tester,
    ) async {
      setViewSize(tester, const Size(390, 844));
      await tester.pumpWidget(sideMenuPage());

      expect(tester.getSize(find.byType(_Counter)).width, 390);
      expect(find.text('menu item').hitTestable(), findsNothing);

      // The content can be operated.
      await tester.tap(find.text('count 0'));
      await tester.pump();
      expect(find.text('count 1'), findsOneWidget);

      // The menu slides in from the menu button ...
      await tester.tap(find.text('メニュー'));
      await tester.pumpAndSettle();
      expect(find.text('menu item').hitTestable(), findsOneWidget);
      expect(find.text('count 1').hitTestable(), findsNothing);

      // ... and closes by tapping outside of it.
      await tester.tapAt(const Offset(380, 400));
      await tester.pumpAndSettle();
      expect(find.text('menu item').hitTestable(), findsNothing);
      expect(find.text('count 1').hitTestable(), findsOneWidget);
    });

    testWidgets('keeps the menu narrower than the screen', (tester) async {
      setViewSize(tester, const Size(300, 600));
      await tester.pumpWidget(sideMenuPage());
      await tester.tap(find.text('メニュー'));
      await tester.pumpAndSettle();

      final menuRight = tester.getRect(find.text('menu item')).right;
      expect(menuRight, lessThan(300 - 40));
    });

    testWidgets('shows a message when the screen is too small', (tester) async {
      setViewSize(tester, const Size(240, 400));
      await tester.pumpWidget(sideMenuPage());

      expect(find.text('画面サイズが足りません'), findsOneWidget);
      expect(find.text('count 0').hitTestable(), findsNothing);
    });

    testWidgets('keeps the content state across layout changes', (
      tester,
    ) async {
      setViewSize(tester, const Size(1280, 800));
      await tester.pumpWidget(sideMenuPage());
      await tester.tap(find.text('count 0'));
      await tester.pump();

      for (final size in const [
        Size(390, 844),
        Size(200, 200),
        Size(1280, 800),
      ]) {
        tester.view.physicalSize = size;
        await tester.pumpAndSettle();
      }
      expect(find.text('count 1'), findsOneWidget);
    });
  });

  group('HomePage', () {
    Widget homePage({PresetModel model = PresetModel.iphone14}) {
      return ProviderScope(
        child: ConfigInherited(
          config: Config(initialModelId: model.id),
          child: SplashShell(
            builder: (_) => MaterialApp(
              builder: (context, child) => HomePage(app: child!),
              home: const Scaffold(body: _Counter()),
            ),
          ),
        ),
      );
    }

    testWidgets('shows the device at a usable size on a phone screen', (
      tester,
    ) async {
      setViewSize(tester, const Size(390, 844));
      await tester.pumpWidget(homePage());
      await tester.pumpAndSettle();

      // The simulated iPhone 14 screen is 390 logical pixels wide. It is
      // scaled down to fit, but must stay large enough to be operated.
      final screenRect = tester.getRect(find.byType(_Counter));
      expect(screenRect.width, greaterThan(300));

      await tester.tap(find.text('count 0'));
      await tester.pump();
      expect(find.text('count 1'), findsOneWidget);
    });

    testWidgets('falls back to a preset for a model without a frame', (
      tester,
    ) async {
      setViewSize(tester, const Size(1280, 800));
      await tester.pumpWidget(homePage(model: PresetModel.galaxyS22));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('count 0'), findsOneWidget);
    });
  });
}

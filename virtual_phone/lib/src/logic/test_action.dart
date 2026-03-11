import 'position.dart';

sealed class TestAction {
  const TestAction({
    required this.id,
  });
  final String id;
}

class TapTestAction extends TestAction {
  const TapTestAction({
    required super.id,
    required this.position,
  });

  final Position position;
}

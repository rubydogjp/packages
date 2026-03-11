import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../logic/position.dart';
import '../../router/test_scope.dart';
import '../../../state/cursor.dart';

class VirtualTester {
  const VirtualTester({
    required this.cursorPositionNotifier,
    required this.showRipplesNotifier,
  });
  final CursorPositionNotifier cursorPositionNotifier;
  final ShowRipplesNotifier showRipplesNotifier;

  Future<void> moveTo(Position position) async {
    final initialContext = testScopeKey.currentContext;
    if (initialContext == null) return;
    final renderBox = initialContext.findRenderObject();
    if (renderBox is! RenderBox) return;

    final localPosition = Offset(
      position.x,
      position.y,
    );

    // Move cursor
    cursorPositionNotifier.moveTo(
      Position(
        x: localPosition.dx,
        y: localPosition.dy,
      ),
    );

    // wait moving
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> tap(Position position) async {
    try {
      final initialContext = testScopeKey.currentContext;
      if (initialContext == null) return false;
      final renderBox = initialContext.findRenderObject();
      if (renderBox is! RenderBox) return false;

      final localPosition = Offset(
        position.x,
        position.y,
      );
      final globalPosition = renderBox.localToGlobal(localPosition);

      // dispatch TAP down
      final downEvent = PointerDownEvent(position: globalPosition);
      GestureBinding.instance.handlePointerEvent(downEvent);

      // show Effect
      showRipplesNotifier.show();

      // dispatch TAP up
      final upEvent = PointerUpEvent(position: globalPosition);
      GestureBinding.instance.handlePointerEvent(upEvent);

      await Future.delayed(const Duration(milliseconds: 500));
      showRipplesNotifier.hide();
      return true;
    } on Exception {
      return false;
    }
  }
}

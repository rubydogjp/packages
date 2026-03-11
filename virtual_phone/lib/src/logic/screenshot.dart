import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

import '../view/widgets/device/screenshot_rect.dart';

class Screenshot {
  const Screenshot({
    required this.bytes,
    required this.format,
  });

  final Uint8List bytes;
  final ui.ImageByteFormat format;
}

Future<Screenshot> takeScreenshot({
  required double pixelRatio,
}) async {
  final boundary =
      screenshotKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  const pngFormat = ui.ImageByteFormat.png;

  final image = await boundary.toImage(
    pixelRatio: pixelRatio,
  );
  final pngByteData = await image.toByteData(
    format: pngFormat,
  );
  final pngBytes = pngByteData!.buffer.asUint8List();
  return Screenshot(
    bytes: pngBytes,
    format: pngFormat,
  );
}

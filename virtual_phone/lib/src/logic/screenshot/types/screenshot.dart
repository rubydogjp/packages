import 'dart:typed_data';
import 'dart:ui' as ui;

class Screenshot {
  const Screenshot({
    required this.bytes,
    required this.format,
  });

  final Uint8List bytes;
  final ui.ImageByteFormat format;
}

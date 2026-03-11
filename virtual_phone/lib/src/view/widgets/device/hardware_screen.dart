import 'dart:math';

import 'package:flutter/material.dart';

import '../../../logic/device_model/device_model.dart';
import 'screenshot_rect.dart';

class HardwareScreenView extends StatelessWidget {
  const HardwareScreenView({
    super.key,
    required this.deviceModel,
    required this.isPortrait,
    required this.builder,
  });

  final DeviceModel deviceModel;
  final bool isPortrait;
  final Widget Function(SoftwareScreen screen) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mediaQuery = MediaQuery.of(context);
        final hw = deviceModel.hardwareScreen;
        final expectedW =
            isPortrait ? hw.logicalWidth : hw.logicalHeight;
        final expectedH =
            isPortrait ? hw.logicalHeight : hw.logicalWidth;
        final safeArea = isPortrait
            ? hw.safeArea.portrait
            : hw.safeArea.landscape;
        final actualW = constraints.maxWidth;
        final actualH = constraints.maxHeight;

        // Use uniform scaling to prevent stretching. With the
        // AspectRatio constraint in HardwareDeviceView, ratioW ≈ ratioH,
        // but min() guards against any remaining floating-point difference.
        final scale = min(actualW / expectedW, actualH / expectedH);

        return OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: expectedW,
          maxWidth: expectedW,
          minHeight: expectedH,
          maxHeight: expectedH,
          child: Transform.scale(
            alignment: Alignment.topLeft,
            scale: scale,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(hw.logicalCornerRadius),
              child: SizedBox(
                width: expectedW,
                height: expectedH,
                child: ScreenshotRect(
                  child: MediaQuery(
                    data: mediaQuery.copyWith(
                      size: Size(expectedW, expectedH),
                      devicePixelRatio: hw.pixelRatio,
                    ),
                    child: builder(
                      SoftwareScreen(
                        width: expectedW,
                        height: expectedH,
                        cornerRadius: hw.logicalCornerRadius,
                        safeAreaInset: safeArea,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

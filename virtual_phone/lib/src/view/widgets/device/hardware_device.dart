import 'package:flutter/material.dart';

import '../../../logic/device_model/device_model.dart';
import '../../router/rotation_observer.dart';
import 'hardware_screen.dart';

class HardwareDeviceView extends StatelessWidget {
  const HardwareDeviceView({
    super.key,
    required this.deviceModel,
    required this.isPortrait,
    required this.screen,
  });

  /// All information related to the device.
  final DeviceModel deviceModel;

  /// The current frame simulated orientation.
  final bool isPortrait;

  /// The screen that should be inserted into the simulated device.
  final HardwareScreenView screen;

  @override
  Widget build(BuildContext context) {
    final bezel = deviceModel.hardwareScreen.bezelRatio;

    // Compute orientation-aware bezel ratios.
    final leftR = isPortrait ? bezel.left : bezel.top;
    final topR = isPortrait ? bezel.top : bezel.right;
    final rightR = isPortrait ? bezel.right : bezel.bottom;
    final bottomR = isPortrait ? bezel.bottom : bezel.left;

    // Derive the frame image's aspect ratio from the model data.
    // The screen occupies (1 - leftR - rightR) of image width and
    // (1 - topR - bottomR) of image height, so we can compute the
    // image AR from the known logical screen dimensions and the ratios.
    final hw = deviceModel.hardwareScreen;
    final screenW = isPortrait ? hw.logicalWidth : hw.logicalHeight;
    final screenH = isPortrait ? hw.logicalHeight : hw.logicalWidth;
    final imageAR =
        (screenW / screenH) * (1 - topR - bottomR) / (1 - leftR - rightR);

    // Constrain the container to the image's aspect ratio so that
    // BoxFit.contain fills exactly and the ratio-based padding aligns
    // with the actual bezel opening.
    return Center(
      child: AspectRatio(
        aspectRatio: imageAR,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final deviceW = constraints.maxWidth;
            final deviceH = constraints.maxHeight;

            return RotationObserver(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        leftR * deviceW,
                        topR * deviceH,
                        rightR * deviceW,
                        bottomR * deviceH,
                      ),
                      child: screen,
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: true,
                      child: RotatedBox(
                        quarterTurns: isPortrait ? 0 : -1,
                        child: Image.asset(
                          package: 'virtual_phone',
                          deviceModel.hardwareImageUri,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

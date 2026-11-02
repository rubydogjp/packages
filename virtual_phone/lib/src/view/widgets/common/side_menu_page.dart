import 'package:flutter/material.dart';

import '../../theme/colors.dart';

/// Lays out a [menu] and a [content] area, adapting to the available size.
///
/// - Wide: the menu is pinned to the left and the content fills the rest.
/// - Compact: the content fills the screen and the menu slides in from the
///   left when the menu button in the top bar is tapped.
/// - Too small: a message is shown instead. The menu and content stay
///   mounted offstage so their state survives until there is room again.
class SideMenuPage extends StatefulWidget {
  const SideMenuPage({
    super.key,
    required this.menuWidth,
    required this.menu,
    required this.content,
  });

  final double menuWidth;
  final Widget menu;
  final Widget content;

  /// The narrowest content area that still shows the device at a usable size
  /// next to the pinned menu.
  static const minContentWidth = 360.0;

  /// Below this size, there is not enough room to show the device at all.
  static const minSize = Size(280, 280);

  static const compactBarHeight = 48.0;

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  // Keep the menu and content state when switching between layouts.
  final _menuKey = GlobalKey();
  final _contentKey = GlobalKey();

  bool _isMenuOpen = false;

  void _setMenuOpen(bool open) {
    if (_isMenuOpen == open) return;
    setState(() => _isMenuOpen = open);
  }

  @override
  Widget build(BuildContext context) {
    final menu = KeyedSubtree(key: _menuKey, child: widget.menu);
    final content = KeyedSubtree(key: _contentKey, child: widget.content);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final minSize = SideMenuPage.minSize;

          if (size.width < minSize.width || size.height < minSize.height) {
            return Stack(
              children: [
                Offstage(child: _buildCompact(size, menu, content)),
                _TooSmallMessage(size: size, minSize: minSize),
              ],
            );
          }

          if (size.width >= widget.menuWidth + SideMenuPage.minContentWidth) {
            return _buildWide(menu, content);
          }
          return _buildCompact(size, menu, content);
        },
      ),
    );
  }

  Widget _buildWide(Widget menu, Widget content) {
    return Stack(
      children: [
        // back layer
        Row(
          children: [
            SizedBox(width: widget.menuWidth),
            Expanded(child: content),
          ],
        ),
        // front layer
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: BrandColor.shadow,
                    offset: Offset(1, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              width: widget.menuWidth,
              child: menu,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildCompact(Size size, Widget menu, Widget content) {
    // Leave a strip of the scrim visible so the menu can be closed by tapping
    // outside of it.
    final sheetWidth = (size.width - 56).clamp(0.0, widget.menuWidth);
    const duration = Duration(milliseconds: 200);

    return Stack(
      children: [
        Column(
          children: [
            _CompactBar(
              height: SideMenuPage.compactBarHeight,
              onMenuPressed: () => _setMenuOpen(true),
            ),
            Expanded(
              child: ExcludeSemantics(excluding: _isMenuOpen, child: content),
            ),
          ],
        ),
        // scrim
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !_isMenuOpen,
            child: AnimatedOpacity(
              opacity: _isMenuOpen ? 1 : 0,
              duration: duration,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _setMenuOpen(false),
                child: const ColoredBox(color: Colors.black38),
              ),
            ),
          ),
        ),
        // menu sheet
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: sheetWidth,
          child: IgnorePointer(
            ignoring: !_isMenuOpen,
            child: ExcludeSemantics(
              excluding: !_isMenuOpen,
              child: AnimatedSlide(
                offset: _isMenuOpen ? Offset.zero : const Offset(-1.05, 0),
                duration: duration,
                curve: Curves.easeOutCubic,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: BrandColor.shadow,
                        offset: Offset(1, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: SafeArea(right: false, child: menu),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactBar extends StatelessWidget {
  const _CompactBar({required this.height, required this.onMenuPressed});

  final double height;
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BrandColor.background,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              const SizedBox(width: 4),
              TextButton.icon(
                onPressed: onMenuPressed,
                icon: const Icon(Icons.menu),
                label: const Text('メニュー'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TooSmallMessage extends StatelessWidget {
  const _TooSmallMessage({required this.size, required this.minSize});

  final Size size;
  final Size minSize;

  @override
  Widget build(BuildContext context) {
    String format(Size s) => '${s.width.floor()} × ${s.height.floor()}';

    return ColoredBox(
      color: BrandColor.background,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.aspect_ratio, color: BrandColor.weakTitle),
              const SizedBox(height: 8),
              const Text('画面サイズが足りません', textAlign: TextAlign.center),
              const Text(
                'The screen is too small.',
                textAlign: TextAlign.center,
                style: TextStyle(color: BrandColor.weakTitle),
              ),
              const SizedBox(height: 8),
              Text(
                '${format(size)} (min ${format(minSize)})',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: BrandColor.weakTitle,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

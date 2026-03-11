import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnAppear extends HookWidget {
  const OnAppear({
    super.key,
    required this.onAppear,
    required this.child,
  });

  final VoidCallback onAppear;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        onAppear();
        return null;
      },
      const [],
    );
    return child;
  }
}

import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    super.key,
    required this.uri,
  });

  final String uri;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            package: 'virtual_phone',
            uri,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

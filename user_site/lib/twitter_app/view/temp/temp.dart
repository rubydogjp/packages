import 'package:flutter/material.dart';

class TestDialog extends StatelessWidget {
  const TestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('これはテストです'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('閉じる'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

void showTestDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const TestDialog();
    },
  );
}

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '🙈',
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
        Text(
          'Something went wrong!',
          style: theme.textTheme.headlineSmall,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:museumLovers/theme.dart';

class ErrorDisplayView extends StatelessWidget {
  const ErrorDisplayView({Key? key, required this.message, required this.onRetry, this.direction = Axis.vertical})
      : super(key: key);

  final String message;
  final VoidCallback onRetry;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final Widget textWidget = Text(
      message,
      textAlign: direction == Axis.vertical ? TextAlign.center : TextAlign.start,
      style: const TextStyle(color: AppColors.textSecondary),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Flex(
        direction: direction,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (direction == Axis.horizontal) Expanded(child: textWidget) else textWidget,
          const SizedBox(width: 8, height: 8),
          TextButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh, size: 18), label: const Text('Try again')),
        ],
      ),
    );
  }
}

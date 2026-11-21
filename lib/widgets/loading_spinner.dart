import 'package:flutter/material.dart';

/// Native-feeling progress indicator (the activity spinner on iOS).
class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key = defaultKey}) : super(key: key);

  static const Key defaultKey = Key('spinkit');

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 22,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2.2),
        ),
      );
}

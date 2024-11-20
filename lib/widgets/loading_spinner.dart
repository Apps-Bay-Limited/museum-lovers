import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinner extends Center {
  const LoadingSpinner({Key? key = defaultKey})
      : super(
            key: key,
            child: const SpinKitRotatingCircle(
              color: Colors.white38,
              // size: 50.0,
            ));

  static const Key defaultKey = Key('spinkit');
}

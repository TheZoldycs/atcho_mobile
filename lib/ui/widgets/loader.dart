import 'package:atcho/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.color = kMainColor1});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SpinKitCircle(
          color: color!,
          size: 50.0,
        ),
      ),
    );
  }
}
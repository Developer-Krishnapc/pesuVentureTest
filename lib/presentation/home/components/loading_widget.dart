import 'package:flutter/material.dart';

import '../../shared/gen/assets.gen.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 90,
        width: 90,
        child: Assets.lottie.loadingLottie.lottie(
          repeat: true,
        ));
  }
}

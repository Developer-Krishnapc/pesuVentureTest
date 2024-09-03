import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../routes/app_router.gr.dart';
import '../shared/components/app_text_theme.dart';
import '../shared/gen/assets.gen.dart';
import '../shared/providers/router.dart';
import '../theme/app_color.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _timer = Timer(
        const Duration(seconds: 1),
        () async {
          ref.read(routerProvider).replaceAll([const MainRoute()]);
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.rainyBlue, AppColor.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Animate(
            effects: const [
              FadeEffect(
                duration: Duration(seconds: 1),
              ),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.images.rainy.image(height: 200),
                const Gap(20),
                Text(
                  'Weather Pro',
                  style: AppTextTheme.semiBold25
                      .copyWith(color: AppColor.rainyBlue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

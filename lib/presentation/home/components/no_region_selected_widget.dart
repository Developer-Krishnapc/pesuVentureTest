import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/extension/context.dart';
import '../../../core/extension/widget.dart';
import '../../shared/components/app_text_theme.dart';
import '../../shared/components/custom_filled_button.dart';
import '../../theme/app_color.dart';

class NoRegionSelectedWidget extends StatelessWidget {
  const NoRegionSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        children: [
          Text(
            'No Region Selection',
            style: AppTextTheme.medium16.copyWith(color: AppColor.black),
          ),
          CustomFilledButton(
            title: 'Select Region',
            onTap: () {
              context.tabsRouter.setActiveIndex(1);
            },
          ),
          const Gap(40),
        ],
      ).pad(top: context.heightByPercent(40)),
    );
  }
}

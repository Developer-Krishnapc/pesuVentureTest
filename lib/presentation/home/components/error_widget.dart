import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/extension/context.dart';
import '../../shared/components/app_text_theme.dart';
import '../../theme/app_color.dart';
import '../../theme/app_style.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(
      {super.key, required this.error, required this.region});
  final String error;
  final String region;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(context.heightByPercent(35)),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(50),
          decoration: BoxDecoration(
              color: AppColor.red,
              borderRadius: BorderRadius.circular(10),
              boxShadow: AppStyle.shadow),
          child: Text(
            'Opps!,\n$error\nfor region : $region',
            style: AppTextTheme.label14.copyWith(color: AppColor.white),
          ),
        ),
      ],
    );
  }
}

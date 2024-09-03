import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/providers/weather_notifer.dart';
import '../../shared/components/app_text_theme.dart';
import '../../theme/app_color.dart';

class LocationTileWidget extends ConsumerWidget {
  const LocationTileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryList = [
      'United States',
      'Canada',
      'United Kingdom',
      'Australia',
      'Germany',
      'France',
      'Italy',
      'Spain',
      'Japan',
      'China',
      'India',
      'Brazil',
      'Russia',
      'Mexico',
      'South Africa',
      'South Korea',
      'Argentina',
      'Turkey',
      'Saudi Arabia',
      'Netherlands',
      'Sweden',
      'Switzerland',
      'Norway',
      'Denmark',
      'Belgium',
      'Austria',
    ];
    return ListView.builder(
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            ref
                .read(weatherNotifierProvider.notifier)
                .getWeatherByRegion(region: countryList[index]);

            context.tabsRouter.setActiveIndex(0);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              countryList[index],
              style: AppTextTheme.label14.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

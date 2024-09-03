import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../core/extension/widget.dart';
import '../home/providers/weather_notifer.dart';
import '../shared/components/app_text_theme.dart';
import '../shared/components/search_widget.dart';
import '../theme/app_color.dart';
import 'components/LocationTile.dart';

@RoutePage()
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () {
            ref.read(weatherNotifierProvider.notifier).getWeatherByLatLng();

            context.tabsRouter.setActiveIndex(0);
          },
          child: const Icon(
            Icons.gps_fixed_outlined,
            color: AppColor.white,
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColor.lightGrey, AppColor.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Text(
                  'Locations',
                  style: AppTextTheme.semiBold25,
                ),
                const Gap(10),
                SearchWidget(
                  ctrl: searchCtrl,
                  hintText: 'Search City/Country',
                  onSearch: () {
                    ref
                        .read(weatherNotifierProvider.notifier)
                        .getWeatherByRegion(region: searchCtrl.text.trim());

                    context.tabsRouter.setActiveIndex(0);
                  },
                ),
                const Gap(15),
                Text(
                  'Widely Searched Locations',
                  style: AppTextTheme.label13.copyWith(color: AppColor.grey),
                ),
                const Gap(6),
                const Expanded(child: LocationTileWidget())
              ],
            ).padHor(15),
          ),
        ));
  }
}

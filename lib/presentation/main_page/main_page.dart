// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routes/app_router.gr.dart';
import '../theme/app_color.dart';
import 'section/bottom_nav_bar.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        SearchRoute(),
      ],
      backgroundColor: AppColor.whiteBackground,
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavBar(
          selected: tabsRouter.activeIndex,
          onTabChanged: (data) {
            tabsRouter.setActiveIndex(data);
          }),
    );
  }
}

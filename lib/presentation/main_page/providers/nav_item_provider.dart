import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/gen/assets.gen.dart';

final navItemsProvider = Provider<List<NavData>>((ref) {
  return [
    NavData(
      icon: Assets.svg.homeIcon.path,
    ),
    NavData(
      icon: Assets.svg.searchIcon.path,
    ),
  ];
});

class NavData {
  NavData({
    required this.icon,
  });
  final String icon;
}

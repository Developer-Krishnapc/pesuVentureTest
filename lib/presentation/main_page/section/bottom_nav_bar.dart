import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_color.dart';
import '../providers/nav_item_provider.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({
    super.key,
    required this.selected,
    required this.onTabChanged,
  });
  final int selected;
  final void Function(int index) onTabChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(navItemsProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      height: 60,
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0.2),
            spreadRadius: 0.1,
            color: AppColor.grey,
          ),
        ],
        borderRadius: BorderRadius.circular(100),
        color: AppColor.white,
        // color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final nav = items[index];
          final active = selected == index;
          return Expanded(
            child: InkWell(
              onTap: () => onTabChanged(index),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // SizedBox(

                  //   child:

                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: active ? AppColor.primary : AppColor.white),
                    child: SvgPicture.asset(
                      nav.icon,
                      fit: BoxFit.fitWidth,
                      height: 25,
                      width: 25,
                      color: (active) ? AppColor.white : AppColor.black,
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

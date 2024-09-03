import 'package:flutter/material.dart';

import '../../../core/extension/widget.dart';
import '../../theme/app_color.dart';
import '../gen/assets.gen.dart';
import 'app_text_theme.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget(
      {super.key, this.ctrl, this.hintText, required this.onSearch});
  final TextEditingController? ctrl;
  final String? hintText;
  final VoidCallback onSearch;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String currentString = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Assets.svg.searchIcon.svg(color: AppColor.black, height: 20),
                Expanded(
                  child: TextFormField(
                    controller: widget.ctrl,
                    style: AppTextTheme.label13,
                    onChanged: (data) {
                      currentString = data;
                      setState(() {});
                    },
                    cursorColor: AppColor.primary,
                    decoration: InputDecoration(
                      hintText: widget.hintText ?? 'Search here',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: AppTextTheme.label13,
                      labelStyle: AppTextTheme.label13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.ctrl?.text.isNotEmpty == true)
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              widget.onSearch.call();
            },
            child: const CircleAvatar(
              backgroundColor: AppColor.primary,
              radius: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.white,
                size: 15,
              ),
            ).padLeft(5),
          )
      ],
    );
  }
}

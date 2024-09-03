import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/extension/widget.dart';
import '../../theme/app_color.dart';
import 'app_text_theme.dart';
import 'custom_form_field.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({
    super.key,
    this.formField,
    required this.inputLabel,
    this.mandatory = false,
    this.passwordCtrl,
    this.isPassEmptyValidationRequired,
  });
  final CustomFormField? formField;
  final String inputLabel;
  final bool mandatory;
  final TextEditingController? passwordCtrl;
  final bool? isPassEmptyValidationRequired;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool visible = false;

  void onPasswordVisibilityChanged() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.inputLabel, style: AppTextTheme.label14),
            if (widget.mandatory)
              Text(
                '*',
                style: AppTextTheme.label14.copyWith(color: AppColor.red),
              ).padLeft(5),
          ],
        ),
        const Gap(8),
        widget.formField ?? const SizedBox(),
        if ((widget.inputLabel == 'Password' ||
                widget.inputLabel == 'New Password') &&
            widget.passwordCtrl != null)
          CustomFormField.password(
            passwordVisible: visible,
            onPressed: onPasswordVisibilityChanged,
            controller: widget.passwordCtrl,
            hintText: '**********',
            validator: (data) {
              if ((data == null || data.trim().isEmpty) &&
                  widget.isPassEmptyValidationRequired != false) {
                return 'Please enter password';
              }

              if (data != null && data.isNotEmpty) {
                final regex = RegExp(
                  r'^(?!.*\s)[\S]{8,}$',
                );
                if (!regex.hasMatch(data)) {
                  return 'Password should have minimum 8 characters';
                }
              }

              return null;
            },
          ),
      ],
    );
  }
}

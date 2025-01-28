import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';

class CommonSearchField extends StatelessWidget {
  const CommonSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.color,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? hintText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width > SizeConfig.size700
          ? SizeConfig.size344
          : SizeConfig.size100,
      height: SizeConfig.size48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.size10),
        color: color ??
            ColorConfig.textFieldTextColor.withOpacity(SizeConfig.size0point1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size12),
      child: Row(
        children: [
          Image.asset(
            ImageConfig.searchIcon,
            height: SizeConfig.size18,
            width: SizeConfig.size18,
          ),
          SizeConfig.size12.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              style: FontTextStyleConfig.labelTextStyle
                  .copyWith(color: ColorConfig.searchTextColor),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: onChanged,
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: FontTextStyleConfig.labelTextStyle
                    .copyWith(color: ColorConfig.searchTextColor),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

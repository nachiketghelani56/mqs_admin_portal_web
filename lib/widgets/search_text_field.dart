import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.size271,
      height: SizeConfig.size46,
      decoration: BoxDecoration(
        color:
            ColorConfig.textfieldTextColor.withOpacity(SizeConfig.size0point1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size12),
      child: Row(
        children: [
          Image.asset(
            ImageConfig.search,
            height: SizeConfig.size22,
            width: SizeConfig.size22,
          ),
          SizeConfig.size12.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              style: FontTextstyleConfig.labelTextStyle,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                isDense: true,
                hintText: StringConfig.dashboard.searchUserIdNameEmail,
                hintStyle: FontTextstyleConfig.labelTextStyle,
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

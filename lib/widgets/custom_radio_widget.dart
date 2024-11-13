import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/color_config.dart';
import 'package:mqs_admin_portal_web/config/font_text_style_config.dart';
import 'package:mqs_admin_portal_web/config/size_config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomRadioWidget extends StatelessWidget {
  const CustomRadioWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onChanged});

  final String title;
  final bool isSelected;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: SizeConfig.size16,
          width: SizeConfig.size16,
          padding: const EdgeInsets.all(SizeConfig.size2),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConfig.primaryColor),
            shape: BoxShape.circle,
          ),
          child: isSelected
              ? Container(
                  decoration: const BoxDecoration(
                    color: ColorConfig.primaryColor,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
        ).tap(() {
          onChanged();
        }),
        SizeConfig.size6.width,
        Text(
          title,
          style: FontTextStyleConfig.tableContentTextStyle,
        ),
      ],
    );
  }
}

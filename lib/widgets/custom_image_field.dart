import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomImageField extends StatelessWidget {
  const CustomImageField({
    super.key,
    required this.label,
    required this.onTap,
    required this.image,
  });

  final String label;
  final Function onTap;
  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: FontTextStyleConfig.labelTextStyle,
          ).paddingOnly(left: SizeConfig.size2),
          SizeConfig.size6.height,
          Container(
            height: SizeConfig.size100,
            decoration: BoxDecoration(
              color: ColorConfig.backgroundColor,
              borderRadius: BorderRadius.circular(SizeConfig.size12),
            ),
            padding: const EdgeInsets.all(SizeConfig.size10),
            child: image.isNotEmpty
                ? Image.memory(image)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.upload,
                        color: ColorConfig.primaryColor,
                      ),
                      Text(
                        StringConfig.pathway.uploadImage,
                        style: FontTextStyleConfig.labelTextStyle,
                      ),
                    ],
                  ),
          ).tap(() {
            onTap();
          }),
        ],
      ],
    );
  }
}

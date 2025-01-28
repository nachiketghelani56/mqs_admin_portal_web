import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';

class CustomSecondaryButton extends StatelessWidget {
  const CustomSecondaryButton(
      {super.key,
      this.btnText,
      this.icon,
      required this.onTap,
      this.isSelected = false,
      this.child,
      this.isLoading = false,
      this.isButtonShow = false,
      this.onTapDown,
      this.iconData,
      this.alignment, this.buttonColor, this.textColor});

  final String? btnText;
  final String? icon;
  final Function onTap;
  final bool isSelected;
  final bool isButtonShow;
  final Color? buttonColor;
  final Color? textColor;
  final Widget? child;
  final IconData? iconData;
  final AlignmentGeometry? alignment;

  final bool isLoading;
  final Function(TapDownDetails)? onTapDown;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: onTapDown,
      borderRadius: BorderRadius.circular(SizeConfig.size14),
      onHover: (value) {},
      onTap: () {
        onTap();
      },
      child: Container(
        height: SizeConfig.size47,
        decoration: BoxDecoration(
          color:buttonColor?? ColorConfig.primaryColor.withOpacity(SizeConfig.size0point06),
          borderRadius: BorderRadius.circular(SizeConfig.size10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        alignment: alignment ?? Alignment.center,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : child ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Image.asset(
                        icon ?? "",
                        height: SizeConfig.size18,
                        width: SizeConfig.size18,
                        color: textColor,
                      ),
                      if (!isButtonShow) SizeConfig.size8.width,
                    ],
                    if (iconData != null) ...[
                      Icon(
                        iconData,
                        color:textColor?? ColorConfig.primaryColor,
                      ),
                      if (!isButtonShow) SizeConfig.size6.width,
                    ],
                    if (!isButtonShow)
                      Text(
                        btnText ?? '',
                        style: FontTextStyleConfig.secondaryButtonTextStyle.copyWith(color: textColor),
                      ),
                  ],
                ),
      ),
    );
  }
}

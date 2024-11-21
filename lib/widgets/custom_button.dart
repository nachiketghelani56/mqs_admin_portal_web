import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.btnText,
      required this.onTap,
      this.isSelected = true});

  final String btnText;
  final Function onTap;
  final bool isSelected;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Color btnColor = ColorConfig.primaryColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        if (value) {
          setState(() {
            btnColor = ColorConfig.hoverColor;
          });
        } else {
          setState(() {
            btnColor = ColorConfig.primaryColor;
          });
        }
      },
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: SizeConfig.size50,
        decoration: BoxDecoration(
          color: widget.isSelected ? btnColor : null,
          border: Border.all(color: btnColor),
          borderRadius: BorderRadius.circular(SizeConfig.size14),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.btnText,
          style: FontTextStyleConfig.buttonTextStyle.copyWith(
              color: widget.isSelected ? null : ColorConfig.primaryColor),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class FontTextstyleConfig {
  static const TextStyle titleStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.titleColor,
    fontWeight: FontWeight.w600,
    fontSize: FontSizeConfig.fontSize34,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.titleColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizeConfig.fontSize20,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.whiteColor,
    fontWeight: FontWeight.w500,
    fontSize: FontSizeConfig.fontSize18,
  );

  static const TextStyle textfieldTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.textfieldTextColor,
    fontWeight: FontWeight.w500,
    fontSize: FontSizeConfig.fontSize20,
  );

  static const TextStyle labelTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.labelColor,
    fontWeight: FontWeight.w500,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle tabTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizeConfig.fontSize18,
  );

  static OutlineInputBorder borderDecoration = OutlineInputBorder(
    borderSide: const BorderSide(
      color: ColorConfig.textfieldBorderColor,
    ),
    borderRadius: BorderRadius.circular(SizeConfig.size6),
  );
}

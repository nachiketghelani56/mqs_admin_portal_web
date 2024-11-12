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

  static const TextStyle tableTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.textfieldTextColor,
    fontWeight: FontWeight.w500,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle tableBottomTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.textfieldTextColor,
    fontWeight: FontWeight.w600,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: FontSizeConfig.fontSize18,
  );

  static const TextStyle tableContentTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.textfieldTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizeConfig.fontSize16,
  );

  static OutlineInputBorder borderDecoration = OutlineInputBorder(
    borderSide: const BorderSide(
      color: ColorConfig.textfieldBorderColor,
    ),
    borderRadius: BorderRadius.circular(SizeConfig.size6),
  );

  static BoxDecoration tableTitleDecoration = BoxDecoration(
    color: ColorConfig.bg2Color,
    border: Border.all(
      color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4),
    ),
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(SizeConfig.size12),
    ),
  );

  static BoxDecoration tableRowDecoration = BoxDecoration(
    border: Border(
      left: BorderSide(
        color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4),
      ),
      right: BorderSide(
        color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4),
      ),
      bottom: BorderSide(
        color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4),
      ),
    ),
  );

  static BoxDecoration tableBottomDecoration = BoxDecoration(
    color: ColorConfig.bg2Color,
    border: Border.all(
      color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4),
    ),
    borderRadius: const BorderRadius.vertical(
      bottom: Radius.circular(SizeConfig.size12),
    ),
  );

  static BoxDecoration detailMainDecoration = BoxDecoration(
    border: Border.all(
      color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point2),
    ),
    borderRadius: BorderRadius.circular(SizeConfig.size12),
  );

  static BoxDecoration detailDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(
        color:
            ColorConfig.textfieldTextColor.withOpacity(SizeConfig.size0point14),
      ),
      bottom: BorderSide(
        color:
            ColorConfig.textfieldTextColor.withOpacity(SizeConfig.size0point14),
      ),
    ),
  );

  static BoxDecoration detailBottomDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color:
            ColorConfig.textfieldTextColor.withOpacity(SizeConfig.size0point14),
      ),
    ),
  );

  static BoxDecoration detailLeftDecoration = BoxDecoration(
    border: Border(
      left: BorderSide(
        color: ColorConfig.textfieldTextColor.withOpacity(.14),
      ),
    ),
  );

  static BoxDecoration headerDecoration = BoxDecoration(
    color: ColorConfig.bg2Color.withOpacity(SizeConfig.size0point3),
    border: Border.all(
      color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point2),
    ),
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(SizeConfig.size12),
    ),
  );

  static BoxDecoration contentDecoration = BoxDecoration(
    color: ColorConfig.bg2Color.withOpacity(SizeConfig.size0point3),
    border: Border(
      left: BorderSide(
        color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point2),
      ),
      bottom: BorderSide(
        color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point2),
      ),
      right: BorderSide(
        color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point2),
      ),
    ),
  );

  static BoxDecoration filterDecoration = BoxDecoration(
    border: Border.all(
      color: ColorConfig.textfieldTextColor.withOpacity(SizeConfig.size0point1),
    ),
    borderRadius: BorderRadius.circular(SizeConfig.size6),
  );

  static BoxDecoration optionDecoration = BoxDecoration(
    color: ColorConfig.primaryColor,
    borderRadius: BorderRadius.circular(SizeConfig.size2),
  );

  static BoxDecoration subOptionDecoration = BoxDecoration(
    color: ColorConfig.textfieldTextColor.withOpacity(SizeConfig.size0point06),
    borderRadius: BorderRadius.circular(SizeConfig.size4),
  );
}

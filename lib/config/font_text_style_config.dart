import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class FontTextStyleConfig {
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
  static const TextStyle secondaryButtonTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.primaryColor,
    fontWeight: FontWeight.w600,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.whiteColor,
    fontWeight: FontWeight.w500,
    fontSize: FontSizeConfig.fontSize18,
  );

  static const TextStyle textFieldTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.textFieldTextColor,
    fontWeight: FontWeight.w500,
    fontSize: FontSizeConfig.fontSize20,
  );

  static const TextStyle navigationTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.navigationTextColor,
    fontWeight: FontWeight.w700,
    fontSize: FontSizeConfig.fontSize22,
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
    color: ColorConfig.textFieldTextColor,
    fontWeight: FontWeight.w500,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle tableBottomTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.textFieldTextColor,
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
    color: ColorConfig.textFieldTextColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle menuTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.whiteColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizeConfig.fontSize16,
  );

  static TextStyle subMenuTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.whiteColor.withOpacity(SizeConfig.size0point7),
    fontWeight: FontWeight.w300,
    fontSize: FontSizeConfig.fontSize14,
  );

  static const TextStyle dateTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.primaryColor,
    fontWeight: FontWeight.w300,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle headerTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizeConfig.fontSize24,
  );

  static const TextStyle cardTitleTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.cardTitleColor,
    fontWeight: FontWeight.w300,
    fontSize: FontSizeConfig.fontSize20,
  );

  static const TextStyle fieldTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: FontSizeConfig.fontSize16,
  );

  static const TextStyle cardMainTextStyle = TextStyle(
    fontSize: FontSizeConfig.fontSize64,
    color: ColorConfig.card1TextColor,
    fontFamily: FontFamilyConfig.figtree,
    fontWeight: FontWeight.w600,
    height: SizeConfig.size1,
  );

  static const TextStyle cardSubTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.cardTitleColor,
    fontSize: FontSizeConfig.fontSize24,
    fontWeight: FontWeight.w300,
    height: SizeConfig.size1,
  );

  static const TextStyle homeTitleTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.primaryColor,
    fontSize: FontSizeConfig.fontSize28,
    fontWeight: FontWeight.w300,
    height: SizeConfig.size1,
  );

  static const TextStyle homeTitleUpTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.cardTitleColor,
    fontSize: FontSizeConfig.fontSize8,
    fontWeight: FontWeight.w300,
    height: SizeConfig.size1,
  );

  static const TextStyle searchTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    fontSize: FontSizeConfig.fontSize16,
    fontWeight: FontWeight.w300,
    color: ColorConfig.primaryColor,
  );

  static const TextStyle chartTitleTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    fontSize: FontSizeConfig.fontSize32,
    fontWeight: FontWeight.w400,
    color: ColorConfig.primaryColor,
  );

  static const TextStyle chartDescTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    fontSize: FontSizeConfig.fontSize22,
    fontWeight: FontWeight.w400,
    color: ColorConfig.primaryColor,
  );

  static OutlineInputBorder borderDecoration = OutlineInputBorder(
    borderSide: const BorderSide(
      color: ColorConfig.transparentColor,
    ),
    borderRadius: BorderRadius.circular(SizeConfig.size12),
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
            ColorConfig.textFieldTextColor.withOpacity(SizeConfig.size0point14),
      ),
      bottom: BorderSide(
        color:
            ColorConfig.textFieldTextColor.withOpacity(SizeConfig.size0point14),
      ),
    ),
  );

  static BoxDecoration detailBottomDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color:
            ColorConfig.textFieldTextColor.withOpacity(SizeConfig.size0point14),
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
      color: ColorConfig.textFieldTextColor.withOpacity(SizeConfig.size0point1),
    ),
    borderRadius: BorderRadius.circular(SizeConfig.size6),
  );

  static BoxDecoration optionDecoration = BoxDecoration(
    color: ColorConfig.primaryColor,
    borderRadius: BorderRadius.circular(SizeConfig.size2),
  );

  static BoxDecoration subOptionDecoration = BoxDecoration(
    color: ColorConfig.textFieldTextColor.withOpacity(SizeConfig.size0point06),
    borderRadius: BorderRadius.circular(SizeConfig.size4),
  );

  static BoxDecoration topOptionDecoration = BoxDecoration(
    border: Border.all(color: ColorConfig.primaryColor),
    borderRadius: BorderRadius.circular(SizeConfig.size2),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    color: ColorConfig.whiteColor,
    borderRadius: BorderRadius.circular(SizeConfig.size12),
    boxShadow: [
      BoxShadow(
        color: ColorConfig.whiteColor.withOpacity(SizeConfig.size0point06),
        offset: const Offset(SizeConfig.size0, SizeConfig.size4),
        blurRadius: SizeConfig.size38point3,
      )
    ],
  );


  static const BoxDecoration folderDecoration = BoxDecoration(
    color: ColorConfig.whiteColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(SizeConfig.size12),
      topRight: Radius.circular(SizeConfig.size4),
    ),
  );
  static const TextStyle mainHeadingTextStyle = TextStyle(
    fontFamily: FontFamilyConfig.figtree,
    color: ColorConfig.tableTitleColor,
    fontWeight: FontWeight.w700,
    fontSize: FontSizeConfig.fontSize16,
  );
}

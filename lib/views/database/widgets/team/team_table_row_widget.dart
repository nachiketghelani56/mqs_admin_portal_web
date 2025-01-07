import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/database/controller/team_controller.dart';

Widget teamTableRowWidget({

  required TeamController teamController,
  required bool isSelected,
  required BuildContext context,
  required int index,
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.cardDecoration.copyWith(
      borderRadius: BorderRadius.circular(SizeConfig.size0),
      color: isSelected ? ColorConfig.bg2Color : null,
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: Padding(
            padding: const EdgeInsets.only(right: SizeConfig.size15),
            child: Text(
              teamController
                  .team[index].mqsTeamName ??"",
              overflow: TextOverflow.ellipsis,
              style: FontTextStyleConfig.tableTextStyle,
            ),
          ),
        ),
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: Padding(
            padding: const EdgeInsets.only(right: SizeConfig.size15),
            child: Text(
              teamController
                  .team[index].mqsTeamEmail ??"",
              overflow: TextOverflow.ellipsis,
              style: FontTextStyleConfig.tableTextStyle,
            ),
          ),
        ),

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConfig.eyeOpened,
                height: SizeConfig.size24,
              ).tap(() {
                teamController.viewIndex.value = index;
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.teamDetail);
                }
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

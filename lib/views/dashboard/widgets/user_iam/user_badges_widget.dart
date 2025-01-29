import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userBadgesWidget({required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.userBadgesList,
        isShowContent: dashboardController.showMqsUserBadges.value,
      ).tap(() {
        dashboardController.showMqsUserBadges.value =
            !dashboardController.showMqsUserBadges.value;
      }),
      if (dashboardController.showMqsUserBadges.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.badgeName,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.badgeNotes,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.awardTimestamp,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.badgeImage,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i < (dashboardController.userDetail.mqsUserBadges?.length ?? 0);
            i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
            decoration: i ==
                    (dashboardController.userDetail.mqsUserBadges?.length ??
                            0) -
                        1
                ? FontTextStyleConfig.contentDecoration.copyWith(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(SizeConfig.size12),
                    ),
                  )
                : FontTextStyleConfig.contentDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    dashboardController
                            .userDetail.mqsUserBadges?[i].mqsBadgeName ??
                        '',
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    dashboardController
                            .userDetail.mqsUserBadges?[i].mqsBadgeNotes ??
                        "",
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    "${dashboardController.userDetail.mqsUserBadges?[i].mqsAwardTimestamp}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(SizeConfig.size10),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${dashboardController.userDetail.mqsUserBadges?[i].mqsBadgeImage}",
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: ColorConfig.primaryColor,
                        ),
                        fit: BoxFit.cover,
                        height: SizeConfig.size70,
                        width: SizeConfig.size70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}

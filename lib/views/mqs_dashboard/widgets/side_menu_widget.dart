import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget sideMenuWidget(
    {required MqsDashboardController mqsDashboardController}) {
  return Container(
    width: SizeConfig.size263,
    height: Get.height,
    color: ColorConfig.primaryColor,
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizeConfig.size16.height,
          Image.asset(
            ImageConfig.logo,
            height: SizeConfig.size42,
          ).centerLeft.paddingSymmetric(horizontal: SizeConfig.size24),
          SizeConfig.size16.height,
          Container(
            height: SizeConfig.size1,
            color: ColorConfig.secondaryColor,
          ),
          SizeConfig.size40.height,
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size24),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mqsDashboardController.menuItems.length,
            itemBuilder: (context, index) {
              return Obx(
                () => Column(
                  children: [
                    Container(
                      height: SizeConfig.size48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size12),
                      decoration: BoxDecoration(
                        color: index == mqsDashboardController.menuIndex.value
                            ? ColorConfig.whiteColor
                                .withOpacity(SizeConfig.size0point29)
                            : null,
                        borderRadius: BorderRadius.circular(SizeConfig.size12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            mqsDashboardController.menuItems[index].icon,
                            width: SizeConfig.size20,
                          ),
                          SizeConfig.size8.width,
                          Expanded(
                            child: Text(
                              mqsDashboardController.menuItems[index].title,
                              style: FontTextStyleConfig.menuTextStyle,
                            ),
                          ),
                          if (index == mqsDashboardController.menuIndex.value &&
                              mqsDashboardController
                                  .menuItems[index].subtitles.isNotEmpty) ...[
                            SizeConfig.size8.width,
                            Image.asset(
                              ImageConfig.arrowDown,
                              width: SizeConfig.size12,
                              height: SizeConfig.size12,
                            )
                          ],
                        ],
                      ),
                    ).tap(() {
                      mqsDashboardController.menuIndex.value = index;
                      mqsDashboardController.subMenuIndex.value = -1;
                      if (mqsDashboardController.menuIndex.value ==
                          mqsDashboardController.menuItems.length - 1) {
                        Get.toNamed(AppRoutes.teamChart);
                      }
                    }),
                    if (index == mqsDashboardController.menuIndex.value &&
                        mqsDashboardController
                            .menuItems[index].subtitles.isNotEmpty) ...[
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            left: SizeConfig.size38,
                            top: SizeConfig.size12,
                            bottom: SizeConfig.size24),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return Obx(
                            () => Row(
                              children: [
                                Container(
                                  height: SizeConfig.size5,
                                  width: SizeConfig.size5,
                                  decoration: BoxDecoration(
                                      color: ColorConfig.whiteColor.withOpacity(
                                          i ==
                                                  mqsDashboardController
                                                      .subMenuIndex.value
                                              ? SizeConfig.size1
                                              : SizeConfig.size0point7),
                                      shape: BoxShape.circle),
                                ),
                                SizeConfig.size6.width,
                                Text(
                                  mqsDashboardController
                                      .menuItems[index].subtitles[i],
                                  style: i ==
                                          mqsDashboardController
                                              .subMenuIndex.value
                                      ? FontTextStyleConfig.subMenuTextStyle
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: ColorConfig.whiteColor)
                                      : FontTextStyleConfig.subMenuTextStyle,
                                ),
                              ],
                            ).tap(() {
                              mqsDashboardController.subMenuIndex.value = i;
                            }),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizeConfig.size12.height,
                        itemCount: mqsDashboardController
                            .menuItems[index].subtitles.length,
                      )
                    ],
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizeConfig.size8.height,
          ),
        ],
      ),
    ),
  );
}

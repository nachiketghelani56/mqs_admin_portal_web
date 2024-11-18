import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDemographicWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.demoGraphicValue,
        isShowContent: dashboardController.showDemographic.value,
      ).tap(() {
        dashboardController.showDemographic.value =
            !dashboardController.showDemographic.value;
      }),
      if (dashboardController.showDemographic.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  StringConfig.dashboard.currentSelectedAnswer,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.selectedIndex,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i <
                dashboardController
                    .userDetail.onboardingModel.demoGraphicValue.length;
            i++)
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: i ==
                    dashboardController.userDetail.onboardingModel
                            .demoGraphicValue.length -
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
                  child: Text(
                    dashboardController.userDetail.onboardingModel
                        .demoGraphicValue[i].currentSelectedAnswer,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${dashboardController.userDetail.onboardingModel.demoGraphicValue[i].selectedIndex}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}

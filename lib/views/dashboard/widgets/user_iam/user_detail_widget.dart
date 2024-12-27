import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_detail_row_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_enterprise_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_onboarding_data_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_subscription_detail_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDetailWidget({required DashboardController dashboardController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(
            title: StringConfig.dashboard.userInformation,
            showArrowIcon: false,
          ),
          SizeConfig.size10.height,
          userDetailRowWidget(dashboardController: dashboardController),
          SizeConfig.size34.height,
          userEnterpriseDetailWidget(dashboardController: dashboardController),
          SizeConfig.size34.height,
          userSubscriptionDetailWidget(
              dashboardController: dashboardController),
          SizeConfig.size34.height,
          if(!(dashboardController
              .userDetail.onboardingModel.checkInValue.isEmpty  && dashboardController
              .userDetail.onboardingModel.demoGraphicValue.isEmpty && dashboardController
              .userDetail.onboardingModel.scenesValue.isEmpty &&dashboardController.userDetail.onboardingModel.wOLValue
              .toJson()
              .toString() ==
              "{}"))
            ...[
              userOnboardingDataWidget(dashboardController: dashboardController),
              SizeConfig.size34.height,
            ],

          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.headerDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    StringConfig.csv.createdTimestamp,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.csv.updatedTimestamp,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.contentDecoration.copyWith(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(SizeConfig.size12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    dashboardController.dateConvert(
                        dashboardController.userDetail.mqsCreatedTimestamp),
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    dashboardController.dateConvert(
                        dashboardController.userDetail.mqsUpdateTimestamp),
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

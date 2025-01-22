import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_challenge_status_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_detail_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_enterprise_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_growth_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_jms_status_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_milestone_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_privacy_setting_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_profile_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_subscription_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_onboarding_data_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataDetailWidget({required UserDataController userDataController}) {
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
          userDataDetailRowWidget(userDataController: userDataController),
          SizeConfig.size34.height,
          userDataEnterpriseDetailWidget(userDataController: userDataController),
          SizeConfig.size34.height,
          userDataSubscriptionDetailWidget(
              userDataController: userDataController),
          SizeConfig.size34.height,

          userDataOnboardingDataWidget(userDataController: userDataController),
          SizeConfig.size34.height,
          userDataJMSStatusWidget(userDataController: userDataController),
          SizeConfig.size34.height,
          userDataChallengeStatusWidget(userDataController: userDataController),
          SizeConfig.size34.height,
          userDataPrivacySettingDetailWidget(
              userDataController: userDataController),
          SizeConfig.size34.height,
          userDataGrowthWidget(userDataController: userDataController),
          SizeConfig.size34.height,
          userDataProfileWidget(userDataController: userDataController),
          SizeConfig.size34.height,
          if (userDataController.userDetail.mqsUserMilestones?.isNotEmpty ??
              false) ...[
            userDataMileStoneWidget(userDataController: userDataController),
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
                    userDataController.dateConvert(userDataController
                                .userDetail.mqsCreatedTimestamp?.isNotEmpty ??
                            false
                        ? userDataController.userDetail.mqsCreatedTimestamp ??
                            ''
                        : userDataController
                                    .userDetail
                                    .mqsEnterpriseCreatedTimestamp
                                    ?.isNotEmpty ??
                                false
                            ? userDataController
                                    .userDetail.mqsEnterpriseCreatedTimestamp ??
                                ""
                            : DateTime.now().toIso8601String()),
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    userDataController.dateConvert(
                        userDataController.userDetail.mqsUpdatedTimestamp ??
                            ""),
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

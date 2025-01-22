import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataPrivacySettingDetailWidget(
    {required UserDataController userDataController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.privacySettingsDetails,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSActivityLogs,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSActivityLogs.toString().capitalize}",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleAbout,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleAbout.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleCountry,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleCountry.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleName,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleName.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleProfilePicture,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleProfilePicture.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCirclePronouns,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCirclePronouns.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSOutreach,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSOutreach.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSSurveysAndStudies,
        value:
            "${userDataController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSSurveysAndStudies.toString().capitalize}",
        isLast: true,
      ),
    ],
  );
}

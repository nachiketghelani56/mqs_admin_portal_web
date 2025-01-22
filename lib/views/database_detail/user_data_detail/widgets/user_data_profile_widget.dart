import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataProfileWidget({required UserDataController userDataController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.userProfile,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.about,
        value: userDataController.userDetail.mqsUserProfile?.mqsAbout ?? "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.country,
        value: userDataController.userDetail.mqsUserProfile?.mqsCountry ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.pronouns,
        value: userDataController.userDetail.mqsUserProfile?.mqsPronouns ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.postal,
        value: userDataController.userDetail.mqsUserProfile?.mqsPostal ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.profession,
        value:
            userDataController.userDetail.mqsUserProfile?.mqsProfession ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsAgeGroup,
        value: userDataController.userDetail.mqsUserProfile?.mqsAgeGroup ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.userImageText,
        value: "${userDataController.userDetail.mqsUserProfile?.mqsUserImage}",
        isImage: true,
        isLast: true,
      ),
    ],
  );
}

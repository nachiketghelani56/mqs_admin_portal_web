import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataJMSStatusWidget({required UserDataController userDataController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.userJMSStatus,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserInPathway,
        value:userDataController.userDetail.mqsUserJMStatus?.mqsUserInPathway != null?
            "${userDataController.userDetail.mqsUserJMStatus?.mqsUserInPathway.toString().capitalize}" : "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPathwayID,
        value:
            userDataController.userDetail.mqsUserJMStatus?.mqsUserPathwayID ??
                "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPathwayLevel,
        value:userDataController
            .userDetail.mqsUserJMStatus?.mqsUserPathwayLevel != null ?userDataController
                .userDetail.mqsUserJMStatus?.mqsUserPathwayLevel
                .toString() ??
            "" : "0",

      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsPathwayScreenList,
        value:
        userDataController
            .userDetail.mqsUserJMStatus?.mqsPathwayScreenList?.map((e)=>e).join("   |   ") ?? "",

      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsCompletedPathwayList,
        value:
        userDataController
            .userDetail.mqsUserJMStatus?.mqsCompletedPathwayList?.map((e)=>e).join("   |   ")?? "",
        isLast: true,
      ),
    ],
  );
}

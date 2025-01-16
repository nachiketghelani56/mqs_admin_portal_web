import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/add_circle_data_form_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/hashtag_data_form_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';

Widget addCircleDataWidget(
    {required CircleDataController circleDataController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {
  GlobalKey<FormState> circleFormKey = GlobalKey<FormState>();
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Form(
        key: circleFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              circleDataController.isEdit.value
                  ? StringConfig.database.editCircleInformation
                  : StringConfig.database.addCircleInformation,
              style: FontTextStyleConfig.textFieldTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizeConfig.size24.height,
            addCircleDataFormWidget(circleDataController: circleDataController,context: context),
            SizeConfig.size34.height,
            hashtagDataFormWidget(circleDataController: circleDataController,context: context),
            SizeConfig.size34.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onTap: () {
                    circleDataController.isEdit.value = false;
                    circleDataController.isAdd.value = false;
                    mqsDashboardController.circleStatus.value = "";
                  },
                  isSelected: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size40),
                    child: Text(
                      StringConfig.dashboard.cancel,
                      style: FontTextStyleConfig.buttonTextStyle
                          .copyWith(color: ColorConfig.primaryColor),
                    ),
                  ),
                ),
                SizeConfig.size24.width,
                CustomButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size40),
                    child: Text(
                      circleDataController.isEdit.value
                          ? StringConfig.dashboard.update
                          : StringConfig.dashboard.submit,
                      style: FontTextStyleConfig.buttonTextStyle
                          .copyWith(color: null),
                    ),
                  ),
                  onTap: () {
                    if (circleFormKey.currentState?.validate() ?? false) {
                      circleDataController.addCircle();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/add_circle_form_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/hashtag_form_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';

Widget addCircleWidget(
    {required CircleController circleController,
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
              circleController.isEdit.value
                  ? StringConfig.circle.editCircle
                  : StringConfig.circle.addCircle,
              style: FontTextStyleConfig.textFieldTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizeConfig.size24.height,
            addCircleFormWidget(circleController: circleController),
            SizeConfig.size34.height,
            hashtagFormWidget(circleController: circleController),
            SizeConfig.size34.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomButton(
                    btnText: StringConfig.dashboard.cancel,
                    onTap: () {
                      circleController.isEdit.value = false;
                      circleController.isAdd.value = false;
                      if (Get.currentRoute == AppRoutes.addCircle) {
                        Get.back();
                      }
                    },
                    isSelected: false,
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomButton(
                    btnText: circleController.isEdit.value
                        ? StringConfig.dashboard.update
                        : StringConfig.dashboard.submit,
                    onTap: () {
                      if (circleFormKey.currentState?.validate() ?? false) {
                        circleController.addCircle();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

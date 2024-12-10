import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/add_pathway_form_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/module_form_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_dep_form_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';

Widget addPathwayWidget(
    {required PathwayController pathwayController,
    required BuildContext context}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Form(
        key: pathwayController.pathwayFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pathwayController.isEdit.value
                  ? StringConfig.pathway.editPathway
                  : StringConfig.pathway.addPathway,
              style: FontTextStyleConfig.textFieldTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizeConfig.size24.height,
            addPathwayFormWidget(pathwayController: pathwayController),
            SizeConfig.size34.height,
            pathwayDepFormWidget(pathwayController: pathwayController),
            SizeConfig.size34.height,
            moduleFormWidget(pathwayController: pathwayController),
            SizeConfig.size34.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomButton(
                    btnText: StringConfig.dashboard.cancel,
                    onTap: () {
                      pathwayController.isEdit.value = false;
                      pathwayController.isAdd.value = false;
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
                    btnText: pathwayController.isEdit.value
                        ? StringConfig.dashboard.update
                        : StringConfig.dashboard.submit,
                    onTap: () {
                      pathwayController.addPathway();
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

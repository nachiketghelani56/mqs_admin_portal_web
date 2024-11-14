import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';

enterpriseDeleteDialogWidget(
    {required BuildContext context,
    required DashboardController dashboardController,
    required String docId}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.size10)),
        child: Container(
          width: SizeConfig.size406,
          padding: const EdgeInsets.all(SizeConfig.size22),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  ImageConfig.delete,
                  height: SizeConfig.size74,
                ),
                SizeConfig.size8.height,
                Text(
                  StringConfig.dashboard.areYouSureYouWantToDeleteThis,
                  style: FontTextStyleConfig.tableTextStyle,
                ),
                Text(
                  docId,
                  style: FontTextStyleConfig.textFieldTextStyle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${StringConfig.dashboard.enterprise}?',
                  style: FontTextStyleConfig.tableTextStyle,
                ),
                SizeConfig.size32.height,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        isSelected: false,
                        btnText: StringConfig.dashboard.cancel,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizeConfig.size12.width,
                    Expanded(
                      child: CustomButton(
                        btnText: StringConfig.dashboard.yesDelete,
                        onTap: () {
                          Get.back();
                          dashboardController.deleteEnterprise(docId: docId);
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
    },
  );
}

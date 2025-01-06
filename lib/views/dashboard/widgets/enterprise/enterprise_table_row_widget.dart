import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_delete_dialog_widget.dart';

Widget enterpriseTableRowWidget({
  required DashboardController dashboardController,
  required bool isSelected,
  required BuildContext context,
  required int index,
  bool isReport = false,
  bool isStorage= false
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.cardDecoration.copyWith(
      borderRadius: BorderRadius.circular(SizeConfig.size0),
      color: isSelected ? ColorConfig.bg2Color : null,
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size4.toInt(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
            child: Text(
              dashboardController.searchedEnterprises[index].mqsEnterpriseCode,
              overflow: TextOverflow.ellipsis,
              style: FontTextStyleConfig.tableTextStyle.copyWith(
                fontSize: FontSizeConfig.fontSize15,
              ),
            ),
          ),
        ),
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
            child: Text(
              dashboardController.searchedEnterprises[index]
                  .mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus,
              overflow: TextOverflow.ellipsis,
              style: FontTextStyleConfig.tableTextStyle.copyWith(
                fontSize: FontSizeConfig.fontSize15,
              ),
            ),
          ),
        ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                ImageConfig.eyeOpened,
                height: SizeConfig.size24,
              ).tap(() {
                dashboardController.isAddEnterprise.value = false;
                dashboardController.isEditEnterprise.value = false;
                dashboardController.viewIndex.value = index;
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.enterpriseDetail);
                }
              }),
              if (!(isReport || isStorage)) ...[
                Image.asset(
                  ImageConfig.edit,
                  height: SizeConfig.size24,
                ).tap(() {
                  dashboardController.showMqsTeamList.value = false;
                  dashboardController.showMqsEmpEmailList.value = false;
                  dashboardController.showMqsEnterprisePocsList.value = false;
                  dashboardController.isAddEnterprise.value = false;
                  dashboardController.isEditEnterprise.value = true;
                  dashboardController.viewIndex.value = index;
                  dashboardController.setEnterpriseForm(index: index);
                  if (context.width < SizeConfig.size1500) {
                    Get.toNamed(AppRoutes.addEnterprise);
                  }
                }),
                Image.asset(
                  ImageConfig.delete,
                  height: SizeConfig.size24,
                ).tap(() {
                  enterpriseDeleteDialogWidget(
                    context: context,
                    dashboardController: dashboardController,
                    docId: dashboardController.searchedEnterprises[index]
                            .mqsEnterprisePOCsList.isNotEmpty
                        ? dashboardController.searchedEnterprises[index]
                            .mqsEnterprisePOCsList.first.mqsEnterpriseID
                        : dashboardController.searchedEnterprises[index].docId,
                      mqsEnterpriseName: "",
                  );
                }),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

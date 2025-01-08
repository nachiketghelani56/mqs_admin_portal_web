import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/enterprise_data_delete_dialog_widget.dart';

Widget enterpriseDataTableRowWidget({
  required EnterpriseDataController enterpriseDataController,
  required bool isSelected,
  required BuildContext context,
  required int index,
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
                enterpriseDataController
                    .searchedEnterprises[index].mqsEnterpriseCode,
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
                enterpriseDataController.searchedEnterprises[index]
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
                  enterpriseDataController.isAddEnterprise.value = false;
                  enterpriseDataController.isEditEnterprise.value = false;
                  enterpriseDataController.viewIndex.value = index;
                  if (context.width < SizeConfig.size1500) {
                    Get.toNamed(AppRoutes.enterpriseDataDetail);
                  }
                }),
                Image.asset(
                  ImageConfig.edit,
                  height: SizeConfig.size24,
                ).tap(() {
                  enterpriseDataController.showMqsTeamList.value = false;
                  enterpriseDataController.showMqsEmpEmailList.value = false;
                  enterpriseDataController.showMqsEnterprisePocsList.value =
                      false;
                  enterpriseDataController.isAddEnterprise.value = false;
                  enterpriseDataController.isEditEnterprise.value = true;
                  enterpriseDataController.viewIndex.value = index;
                  enterpriseDataController.setEnterpriseForm(index: index);
                  if (context.width < SizeConfig.size1500) {
                    Get.toNamed(AppRoutes.addEnterpriseData);
                  }
                }),
                Image.asset(
                  ImageConfig.delete,
                  height: SizeConfig.size24,
                ).tap(() {
                  enterpriseDataDeleteDialogWidget(
                    context: context,
                    enterpriseDataController: enterpriseDataController,
                    docId: enterpriseDataController.searchedEnterprises[index]
                            .mqsEnterprisePOCsList.isNotEmpty
                        ? enterpriseDataController.searchedEnterprises[index]
                            .mqsEnterprisePOCsList.first.mqsEnterpriseID
                        : enterpriseDataController
                            .searchedEnterprises[index].docId,
                    mqsEnterpriseName: "",
                  );
                }),
              ],
            ),
          ),
        ],
      ));
}

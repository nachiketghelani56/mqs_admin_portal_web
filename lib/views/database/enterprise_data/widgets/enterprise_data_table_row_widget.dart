import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/enterprise_data_delete_dialog_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget enterpriseDataTableRowWidget({
  required EnterpriseDataController enterpriseDataController,
  required MqsDashboardController mqsDashboardController,
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
    child: context.width > SizeConfig.size1500
        ? Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    enterpriseDataController
                        .searchedEnterprises[index]
                        .mqsEnterpriseSubscriptionDetails
                        .mqsSubscriptionActivePlan,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
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
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    enterpriseDataController.dateConvert(
                        enterpriseDataController
                            .searchedEnterprises[index]
                            .mqsEnterpriseSubscriptionDetails
                            .mqsSubscriptionActivationTimestamp),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    enterpriseDataController.dateConvert(
                        enterpriseDataController
                            .searchedEnterprises[index]
                            .mqsEnterpriseSubscriptionDetails
                            .mqsSubscriptionExpiryTimestamp),
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

                      mqsDashboardController.enterpriseStatus.value =
                          "view_enterprise";
                    }),
                    Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      enterpriseDataController.showMqsTeamList.value = false;
                      enterpriseDataController.showMqsEmpEmailList.value =
                          false;
                      enterpriseDataController.showMqsEnterprisePocsList.value =
                          false;
                      enterpriseDataController.isAddEnterprise.value = false;
                      enterpriseDataController.isEditEnterprise.value = true;
                      enterpriseDataController.viewIndex.value = index;
                      enterpriseDataController.setEnterpriseForm(index: index);

                      mqsDashboardController.enterpriseStatus.value =
                          "add_enterprise";
                    }),
                    Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      enterpriseDataDeleteDialogWidget(
                        context: context,
                        enterpriseDataController: enterpriseDataController,
                        docId: enterpriseDataController
                                .searchedEnterprises[index]
                                .mqsEnterprisePOCsList
                                .isNotEmpty
                            ? enterpriseDataController
                                .searchedEnterprises[index]
                                .mqsEnterprisePOCsList
                                .first
                                .mqsEnterpriseID
                            : enterpriseDataController
                                .searchedEnterprises[index].docId,
                        mqsDashboardController: mqsDashboardController,
                        mqsEnterpriseName: "",
                      );
                    }),
                  ],
                ),
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    enterpriseDataController
                        .searchedEnterprises[index]
                        .mqsEnterpriseSubscriptionDetails
                        .mqsSubscriptionActivePlan,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.eyeOpened,
                      height: SizeConfig.size24,
                    ).tap(() {
                      enterpriseDataController.isAddEnterprise.value = false;
                      enterpriseDataController.isEditEnterprise.value = false;
                      enterpriseDataController.viewIndex.value = index;
                      mqsDashboardController.enterpriseStatus.value =
                          "view_enterprise";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      enterpriseDataController.showMqsTeamList.value = false;
                      enterpriseDataController.showMqsEmpEmailList.value =
                          false;
                      enterpriseDataController.showMqsEnterprisePocsList.value =
                          false;
                      enterpriseDataController.isAddEnterprise.value = false;
                      enterpriseDataController.isEditEnterprise.value = true;
                      enterpriseDataController.viewIndex.value = index;
                      enterpriseDataController.setEnterpriseForm(index: index);

                      mqsDashboardController.enterpriseStatus.value =
                          "add_enterprise";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      enterpriseDataDeleteDialogWidget(
                        context: context,
                        enterpriseDataController: enterpriseDataController,
                        docId: enterpriseDataController
                                .searchedEnterprises[index]
                                .mqsEnterprisePOCsList
                                .isNotEmpty
                            ? enterpriseDataController
                                .searchedEnterprises[index]
                                .mqsEnterprisePOCsList
                                .first
                                .mqsEnterpriseID
                            : enterpriseDataController
                                .searchedEnterprises[index].docId,
                        mqsDashboardController: mqsDashboardController,
                        mqsEnterpriseName: "",
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget userDataTableRowWidget({
  required UserDataController userDataController,
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
                    '${userDataController.searchedUsers[index].mqsFirstName} ${userDataController.searchedUsers[index].mqsLastName}',
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    userDataController.searchedUsers[index].mqsEmail ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    userDataController.searchedUsers[index].mqsMONGODBUserID ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    userDataController.searchedUsers[index].mqsUserID ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    userDataController.searchedUsers[index].mqsUserLoginWith ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
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
                      // enterpriseDataController.isAddEnterprise.value = false;
                      // enterpriseDataController.isEditEnterprise.value = false;
                      userDataController.viewIndex.value = index;

                      mqsDashboardController.userStatus.value = "view_user";
                    }),
                    Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      // enterpriseDataController.showMqsTeamList.value = false;
                      // enterpriseDataController.showMqsEmpEmailList.value =
                      // false;
                      // enterpriseDataController.showMqsEnterprisePocsList.value =
                      // false;
                      // enterpriseDataController.isAddEnterprise.value = false;
                      // enterpriseDataController.isEditEnterprise.value = true;
                      // enterpriseDataController.viewIndex.value = index;
                      // enterpriseDataController.setEnterpriseForm(index: index);

                      mqsDashboardController.enterpriseStatus.value =
                          "add_enterprise";
                    }),
                    Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      // enterpriseDataDeleteDialogWidget(
                      //   context: context,
                      //   enterpriseDataController: enterpriseDataController,
                      //   docId: enterpriseDataController
                      //       .searchedEnterprises[index]
                      //       .mqsEnterprisePOCsList
                      //       .isNotEmpty
                      //       ? enterpriseDataController
                      //       .searchedEnterprises[index]
                      //       .mqsEnterprisePOCsList
                      //       .first
                      //       .mqsEnterpriseID
                      //       : enterpriseDataController
                      //       .searchedEnterprises[index].docId,
                      //   mqsDashboardController: mqsDashboardController,
                      //   mqsEnterpriseName: "",
                      // );
                    }),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       ImageConfig.eyeOpened,
                //       height: SizeConfig.size24,
                //     ).tap(() {
                //       userDataController.viewIndex.value = index;
                //       mqsDashboardController.userStatus.value =
                //       "view_user";
                //       // if (context.width < SizeConfig.size1500) {
                //       //   Get.toNamed(AppRoutes.userIAMDetail);
                //       // }
                //     }),
                //   ],
                // ),
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
                    '${userDataController.searchedUsers[index].mqsFirstName} ${userDataController.searchedUsers[index].mqsLastName}',
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    userDataController.searchedUsers[index].mqsEmail ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),

              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
                  child: Text(
                    userDataController.searchedUsers[index].mqsUserID ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
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
                      // enterpriseDataController.isAddEnterprise.value = false;
                      // enterpriseDataController.isEditEnterprise.value = false;
                      userDataController.viewIndex.value = index;
                      mqsDashboardController.userStatus.value =
                      "view_user";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      // enterpriseDataController.showMqsTeamList.value = false;
                      // enterpriseDataController.showMqsEmpEmailList.value =
                      // false;
                      // enterpriseDataController.showMqsEnterprisePocsList.value =
                      // false;
                      // enterpriseDataController.isAddEnterprise.value = false;
                      // enterpriseDataController.isEditEnterprise.value = true;
                      userDataController.viewIndex.value = index;
                      // enterpriseDataController.setEnterpriseForm(index: index);

                      mqsDashboardController.userStatus.value =
                      "add_user";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      // enterpriseDataDeleteDialogWidget(
                      //   context: context,
                      //   enterpriseDataController: enterpriseDataController,
                      //   docId: enterpriseDataController
                      //       .searchedEnterprises[index]
                      //       .mqsEnterprisePOCsList
                      //       .isNotEmpty
                      //       ? enterpriseDataController
                      //       .searchedEnterprises[index]
                      //       .mqsEnterprisePOCsList
                      //       .first
                      //       .mqsEnterpriseID
                      //       : enterpriseDataController
                      //       .searchedEnterprises[index].docId,
                      //   mqsDashboardController: mqsDashboardController,
                      //   mqsEnterpriseName: "",
                      // );
                    }),
                  ),
                ],
              ),
            ],
          ),
  );
}

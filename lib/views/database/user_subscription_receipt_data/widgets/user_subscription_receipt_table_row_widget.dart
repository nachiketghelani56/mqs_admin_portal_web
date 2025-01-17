import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/widgets/user_subscription_receipt_delete_dialog_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget userSubscriptionReceiptTableRowWidget({
  required MqsDashboardController mqsDashboardController,
  required UserSubscriptionReceiptController userSubscriptionReceiptController,
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
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController
                            .searchedUserSubRec[index].mqsFirebaseUserID ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController
                            .searchedUserSubRec[index].mqsMONGODBUserID ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController.searchedUserSubRec[index]
                            .mqsSubscriptionActivePlan ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController
                            .searchedUserSubRec[index].mqsSubscriptionStatus ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController.searchedUserSubRec[index]
                            .mqsSubscriptionPlatform ??
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
                      userSubscriptionReceiptController.isAdd.value = false;
                      userSubscriptionReceiptController.isEdit.value = false;
                      userSubscriptionReceiptController.viewIndex.value = index;
                      mqsDashboardController.userSubRecStatus.value =
                          "view_user_sub_rec";
                    }),
                    Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      userSubscriptionReceiptController.viewIndex.value = index;
                      userSubscriptionReceiptController.isAdd.value = false;
                      userSubscriptionReceiptController.isEdit.value = true;
                      userSubscriptionReceiptController.setUserSubRecForm();

                      mqsDashboardController.userSubRecStatus.value =
                          "add_user_sub_rec";
                    }),
                    Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      userSubscriptionReceiptDataDeleteDialogWidget(
                        context: context,
                        userSubscriptionReceiptController:
                            userSubscriptionReceiptController,
                        docId: userSubscriptionReceiptController
                                .searchedUserSubRec[index].id ??
                            "",
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
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController
                            .searchedUserSubRec[index].mqsFirebaseUserID ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController.searchedUserSubRec[index]
                            .mqsSubscriptionActivePlan ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size10),
                  child: Text(
                    userSubscriptionReceiptController.searchedUserSubRec[index]
                            .mqsSubscriptionPlatform ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.eyeOpened,
                      height: SizeConfig.size24,
                    ).tap(() {
                      userSubscriptionReceiptController.isAdd.value = false;
                      userSubscriptionReceiptController.isEdit.value = false;
                      userSubscriptionReceiptController.viewIndex.value = index;
                      mqsDashboardController.userSubRecStatus.value =
                          "view_user_sub_rec";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.edit,
                      height: SizeConfig.size24,
                    ).tap(() {
                      userSubscriptionReceiptController.viewIndex.value = index;
                      userSubscriptionReceiptController.isAdd.value = false;
                      userSubscriptionReceiptController.isEdit.value = true;
                      userSubscriptionReceiptController.setUserSubRecForm();

                      mqsDashboardController.userSubRecStatus.value =
                          "add_user_sub_rec";
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size10),
                    child: Image.asset(
                      ImageConfig.delete,
                      height: SizeConfig.size24,
                    ).tap(() {
                      userSubscriptionReceiptDataDeleteDialogWidget(
                        context: context,
                        userSubscriptionReceiptController:
                            userSubscriptionReceiptController,
                        docId: userSubscriptionReceiptController
                                .searchedUserSubRec[index].id ??
                            "",
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
  );
}

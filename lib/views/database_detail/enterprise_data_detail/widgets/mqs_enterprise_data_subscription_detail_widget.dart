import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterpriseDataSubscriptionDetailWidget(
    {required EnterpriseDataController enterpriseDataController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterpriseSubscriptionDetail,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: FontTextStyleConfig.contentDecoration.copyWith(
          color: ColorConfig.transparentColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(SizeConfig.size12),
            bottom: Radius.circular(SizeConfig.size12),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: SizeConfig.size55,
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
              decoration: FontTextStyleConfig.headerDecoration.copyWith(
                  borderRadius: BorderRadius.circular(SizeConfig.size0),
                  border: Border.symmetric(
                    horizontal: BorderSide(
                        color: ColorConfig.labelColor
                            .withOpacity(SizeConfig.size0point2)),
                  )),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        StringConfig.dashboard.activePlan,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: FontTextStyleConfig.tableBottomTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        StringConfig.dashboard.status,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: FontTextStyleConfig.tableBottomTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        StringConfig.dashboard.activationDate,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: FontTextStyleConfig.tableBottomTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        StringConfig.dashboard.renewalDate,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: FontTextStyleConfig.tableBottomTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        StringConfig.dashboard.expiryDate,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: FontTextStyleConfig.tableBottomTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(minWidth: 0, maxWidth: Get.width),
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
              decoration: FontTextStyleConfig.contentDecoration.copyWith(
                borderRadius: BorderRadius.circular(0),
                border: Border(
                  bottom: BorderSide(
                    color: ColorConfig.labelColor
                        .withOpacity(SizeConfig.size0point2),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        enterpriseDataController
                            .enterpriseDetail
                            .mqsEnterpriseSubscriptionDetails
                            .mqsSubscriptionActivePlan,
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        enterpriseDataController
                            .enterpriseDetail
                            .mqsEnterpriseSubscriptionDetails
                            .mqsSubscriptionStatus,
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        enterpriseDataController.dateConvert(
                            enterpriseDataController
                                .enterpriseDetail
                                .mqsEnterpriseSubscriptionDetails
                                .mqsSubscriptionActivationTimestamp),
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        enterpriseDataController.dateConvert(
                            enterpriseDataController
                                .enterpriseDetail
                                .mqsEnterpriseSubscriptionDetails
                                .mqsSubscriptionRenewalDate),
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: SizeConfig.size3.toInt(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size5),
                      child: Text(
                        enterpriseDataController.dateConvert(
                            enterpriseDataController
                                .enterpriseDetail
                                .mqsEnterpriseSubscriptionDetails
                                .mqsSubscriptionExpiryTimestamp),
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

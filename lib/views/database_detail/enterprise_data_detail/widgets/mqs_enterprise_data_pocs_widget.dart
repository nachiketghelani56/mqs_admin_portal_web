import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterpriseDataPOCsWidget(
    {required EnterpriseDataController enterpriseDataController}) {
  ScrollController scrollController = ScrollController();

  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterprisePOCsList,
        isShowContent: enterpriseDataController.showMqsEnterprisePocsList.value,
      ).tap(() {
        enterpriseDataController.showMqsEnterprisePocsList.value =
            !enterpriseDataController.showMqsEnterprisePocsList.value;
      }),
      if (enterpriseDataController.showMqsEnterprisePocsList.value) ...[
        SizeConfig.size10.height,
        LayoutBuilder(builder: (context, constraints) {
          return MouseRegion(
            onEnter: (_) {
              enterpriseDataController.isHovering.value = true;
            },
            onExit: (_) {
              enterpriseDataController.isHovering.value = false;
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: FontTextStyleConfig.contentDecoration.copyWith(
                color: ColorConfig.transparentColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(SizeConfig.size12),
                  bottom: Radius.circular(SizeConfig.size12),
                ),
              ),
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: enterpriseDataController.isHovering.value,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 0, maxWidth: Get.width),
                        height: SizeConfig.size55,
                        padding: const EdgeInsets.symmetric(
                            horizontal: SizeConfig.size14),
                        decoration: FontTextStyleConfig.headerDecoration
                            .copyWith(
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.size0),
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: ColorConfig.labelColor
                                          .withOpacity(SizeConfig.size0point2)),
                                )),
                        child: Row(
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.name,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.email,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.address,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.phoneNumber,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.type,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.website,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.pinCodeText,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: SizeConfig.size2.toInt(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeConfig.size5),
                                child: Text(
                                  StringConfig.dashboard.signedUp,
                                  style:
                                      FontTextStyleConfig.tableBottomTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (int i = 0;
                          i <
                              enterpriseDataController.enterpriseDetail
                                  .mqsEnterprisePOCsList.length;
                          i++)
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 0, maxWidth: Get.width),
                          padding: const EdgeInsets.symmetric(
                              horizontal: SizeConfig.size14,
                              vertical: SizeConfig.size14),
                          decoration:
                              FontTextStyleConfig.contentDecoration.copyWith(
                            borderRadius: BorderRadius.circular(0),
                            border: i ==
                                    enterpriseDataController.enterpriseDetail
                                            .mqsEnterprisePOCsList.length -
                                        1
                                ? const Border()
                                : Border(
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
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    enterpriseDataController
                                        .enterpriseDetail
                                        .mqsEnterprisePOCsList[i]
                                        .mqsEnterpriseName,
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    enterpriseDataController
                                        .enterpriseDetail
                                        .mqsEnterprisePOCsList[i]
                                        .mqsEnterpriseEmail,
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    enterpriseDataController
                                        .enterpriseDetail
                                        .mqsEnterprisePOCsList[i]
                                        .mqsEnterpriseAddress,
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    enterpriseDataController
                                        .enterpriseDetail
                                        .mqsEnterprisePOCsList[i]
                                        .mqsEnterprisePhoneNumber,
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    enterpriseDataController
                                        .enterpriseDetail
                                        .mqsEnterprisePOCsList[i]
                                        .mqsEnterpriseType,
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    enterpriseDataController
                                        .enterpriseDetail
                                        .mqsEnterprisePOCsList[i]
                                        .mqsEnterpriseWebsite,
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    enterpriseDataController
                                        .enterpriseDetail
                                        .mqsEnterprisePOCsList[i]
                                        .mqsEnterprisePincode,
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: SizeConfig.size2.toInt(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeConfig.size5),
                                  child: Text(
                                    "${enterpriseDataController.enterpriseDetail.mqsEnterprisePOCsList[i].mqsIsSignUp.toString().capitalize}",
                                    style: FontTextStyleConfig
                                        .tableContentTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })
      ],
    ],
  );
}

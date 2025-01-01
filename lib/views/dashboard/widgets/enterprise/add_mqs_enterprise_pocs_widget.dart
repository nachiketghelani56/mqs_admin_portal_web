import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterprisePOCsWidget(
    {required DashboardController dashboardController}) {
  GlobalKey<FormState> enterprisePocsFormKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  return Form(
    key: enterprisePocsFormKey,
    child: Column(
      children: [
        titleWidget(
          title: StringConfig.dashboard.mqsEnterprisePOCsList,
          showAddIcon: true,
        ).tap(() {
          dashboardController.showMqsEnterprisePocsList.value = true;
          dashboardController.clearMqsEntPOCFields();
        }),
      if(dashboardController.enterprisePOCsError.value)
        Align(alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: SizeConfig.size7,left: SizeConfig.size15),
            child: Text(StringConfig.validation.atLeastOneAdd+ StringConfig.dashboard.enterprisePOC+StringConfig.validation.toProceed,
              style: const TextStyle(color: ColorConfig.validationErrorColor,fontSize: FontSizeConfig.fontSize12_5),

            ),
          ),
        ),

        if (dashboardController.showMqsEnterprisePocsList.value) ...[
          SizeConfig.size30.height,
          CustomTextField(
            controller: dashboardController.pocNameController,
            label: StringConfig.dashboard.name,
            hintText: StringConfig.dashboard.enterName,
            validator: (p0) => Validator.emptyValidator(
                p0 ?? "", StringConfig.dashboard.name.toLowerCase()),
          ),
          SizeConfig.size34.height,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.pocEmailController,
                  label: StringConfig.dashboard.emailAddress,
                  hintText: StringConfig.dashboard.enterEmailAddress,
                  validator: (p0) => Validator.emailValidator(
                      p0 ?? "", StringConfig.dashboard.emailAddressText),
                ),
              ),
            ],
          ),
          SizeConfig.size34.height,
          CustomTextField(
            controller: dashboardController.pocAddressController,
            label: StringConfig.dashboard.address,
            hintText: StringConfig.dashboard.enterAddress,
            validator: (p0) => Validator.emptyValidator(
                p0 ?? "", StringConfig.dashboard.address.toLowerCase()),
          ),
          SizeConfig.size34.height,
          CustomTextField(
            controller: dashboardController.pocWebsiteController,
            label: StringConfig.dashboard.website,
            hintText: StringConfig.dashboard.enterWebsite,
            validator: (p0) => Validator.emptyValidator(
                p0 ?? "", StringConfig.dashboard.website.toLowerCase()),
          ),
          SizeConfig.size34.height,
          CustomTextField(
            controller: dashboardController.pocTypeController,
            label: StringConfig.dashboard.type,
            hintText: StringConfig.dashboard.enterType,
            validator: (p0) => Validator.emptyValidator(
                p0 ?? "", StringConfig.dashboard.type.toLowerCase()),
          ),
          SizeConfig.size34.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.pocPhoneNumberController,
                  label: StringConfig.dashboard.phoneNumber,
                  hintText: StringConfig.dashboard.enterPhoneNumber,
                  validator: (p0) => Validator.emptyValidator(p0 ?? "",
                      StringConfig.dashboard.phoneNumber.toLowerCase()),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
              ),
              SizeConfig.size24.width,
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.pocPinCodeController,
                  label: StringConfig.dashboard.pinCode,
                  hintText: StringConfig.dashboard.enterPinCode,
                  validator: (p0) => Validator.emptyValidator(
                      p0 ?? "", StringConfig.dashboard.pinCode.toLowerCase()),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
              ),
            ],
          ),
          SizeConfig.size18.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: SizeConfig.size162,
                child: CustomButton(
                  btnText: StringConfig.dashboard.cancel,
                  onTap: () {
                    dashboardController.clearMqsEntPOCFields();
                    dashboardController.editMqsEntPOCIndex.value = -1;
                    dashboardController.showMqsEnterprisePocsList.value = false;
                  },
                  isSelected: false,
                ),
              ),
              SizeConfig.size12.width,
              SizedBox(
                width: SizeConfig.size162,
                child: CustomButton(
                  btnText: dashboardController.editMqsEntPOCIndex.value >= 0
                      ? StringConfig.dashboard.update
                      : StringConfig.dashboard.submit,
                  onTap: () {
                    if (enterprisePocsFormKey.currentState
                        ?.validate() ??
                        false) {
                      if (dashboardController.editMqsEntPOCIndex.value >= 0) {
                        dashboardController.editMqsEnterprisePOCs();
                      } else {
                        dashboardController.addMqsEnterprisePOCsEmail();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
        if (dashboardController.mqsEnterprisePOCsList.isNotEmpty) ...[
          SizeConfig.size10.height,
          LayoutBuilder(builder: (context, constraints) {
            return MouseRegion(
              onEnter: (_) {
                dashboardController.isHovering.value = true;
              },
              onExit: (_) {
                dashboardController.isHovering.value = false;
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: FontTextStyleConfig.contentDecoration.copyWith(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(SizeConfig.size12),
                    bottom: Radius.circular(SizeConfig.size12),
                  ),
                ),
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: dashboardController.isHovering.value,
                  child: SingleChildScrollView(
                    controller: scrollController,
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
                               Flexible(   fit: FlexFit.tight,
                                  flex: SizeConfig.size2.toInt(),child: const SizedBox()),
                            ],
                          ),
                        ),
                        for (int i = 0;
                        i <
                            dashboardController.mqsEnterprisePOCsList.length;
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
                                  dashboardController.mqsEnterprisePOCsList.length -
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
                                      dashboardController
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
                                      dashboardController
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
                                      dashboardController
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
                                      dashboardController
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
                                      dashboardController
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
                                      dashboardController
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
                                      dashboardController
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
                                      "${dashboardController.mqsEnterprisePOCsList[i].mqsIsSignUp.toString().capitalize}",
                                      style: FontTextStyleConfig
                                          .tableContentTextStyle,
                                    ),
                                  ),
                                ),
                                Flexible( fit: FlexFit.tight,
                                  flex: SizeConfig.size2.toInt(),

                                  child: PopupMenuButton<int>(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: ColorConfig.textFieldBorderColor,
                                    ),
                                    iconSize: SizeConfig.size22,
                                    onSelected: (value) {
                                      if (value == 0) {
                                        dashboardController.setMqsEnterprisePOCsForm(index: i);
                                      } else if (value == 1) {
                                        dashboardController.deleteMqsEnterprisePOCs(index: i);
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        for (int i = 0;
                                        i < dashboardController.options.length;
                                        i++)
                                          PopupMenuItem<int>(
                                            value: i,
                                            child: Container(
                                              width: SizeConfig.size140,
                                              padding: const EdgeInsets.all(SizeConfig.size8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    dashboardController.options[i].icon,
                                                    height: SizeConfig.size24,
                                                  ),
                                                  SizeConfig.size15.width,
                                                  Expanded(
                                                    child: Text(
                                                      dashboardController.options[i].title,
                                                      style: FontTextStyleConfig
                                                          .tableTextStyle
                                                          .copyWith(
                                                          color: dashboardController
                                                              .options[i].color),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ];
                                    },
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

    ),
  );
}

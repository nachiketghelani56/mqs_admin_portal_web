import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterprisePOCsWidget(
    {required DashboardController dashboardController}) {
  return Form(
    key: dashboardController.entPOCFormKey,
    child: Column(
      children: [
        titleWidget(
          title: StringConfig.dashboard.mqsEnterprisePOCs,
          showAddIcon: true,
        ).tap(() {
          dashboardController.showMqsEnterprisePOCs.value = true;
        }),
        if (dashboardController.showMqsEnterprisePOCs.value) ...[
          SizeConfig.size30.height,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.pocAddressController,
                  label: StringConfig.dashboard.address,
                  hintText: StringConfig.dashboard.enterAddress,
                  validator: (p0) => Validator.emptyValidator(
                      p0 ?? "", StringConfig.dashboard.address),
                ),
              ),
            ],
          ),
          SizeConfig.size34.height,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.pocEmailController,
                  label: StringConfig.dashboard.emailAddress,
                  hintText: StringConfig.dashboard.enterEmailAddress,
                  validator: (p0) => Validator.emailValidator(p0 ?? ""),
                ),
              ),
            ],
          ),
          SizeConfig.size34.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.pocNameController,
                  label: StringConfig.dashboard.name,
                  hintText: StringConfig.dashboard.enterName,
                  validator: (p0) => Validator.emptyValidator(
                      p0 ?? "", StringConfig.dashboard.name),
                ),
              ),
              SizeConfig.size24.width,
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.pocPhoneNumberController,
                  label: StringConfig.dashboard.phoneNumber,
                  hintText: StringConfig.dashboard.enterPhoneNumber,
                  validator: (p0) => Validator.emptyValidator(
                      p0 ?? "", StringConfig.dashboard.phoneNumber),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
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
                    dashboardController.showMqsEnterprisePOCs.value = false;
                  },
                  isSelected: false,
                ),
              ),
              SizeConfig.size12.width,
              SizedBox(
                width: SizeConfig.size162,
                child: CustomButton(
                  btnText: dashboardController.editMqsEntPOCIndex.value >= 0
                      ? StringConfig.dashboard.edit
                      : StringConfig.dashboard.add,
                  onTap: () {
                    if (dashboardController.entPOCFormKey.currentState
                            ?.validate() ??
                        false) {
                      if (dashboardController.editMqsEntPOCIndex.value >= 0) {
                        dashboardController.editMqsEntPOC();
                      } else {
                        dashboardController.addMqsEntPOC();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
        if (dashboardController.mqsEnterprisePOCs.isNotEmpty) ...[
          SizeConfig.size30.height,
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.headerDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.dashboard.address,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.dashboard.email,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    StringConfig.dashboard.name,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    StringConfig.dashboard.phoneNumber,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          for (int i = 0; i < dashboardController.mqsEnterprisePOCs.length; i++)
            Container(
              height: SizeConfig.size55,
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
              decoration: i == dashboardController.mqsEnterprisePOCs.length - 1
                  ? FontTextStyleConfig.contentDecoration.copyWith(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(SizeConfig.size12),
                      ),
                    )
                  : FontTextStyleConfig.contentDecoration,
              child: Row(
                children: [
                  Expanded(
                    flex: SizeConfig.size3.toInt(),
                    child: Text(
                      dashboardController.mqsEnterprisePOCs[i].address,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size3.toInt(),
                    child: Text(
                      dashboardController.mqsEnterprisePOCs[i].email,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size2.toInt(),
                    child: Text(
                      dashboardController.mqsEnterprisePOCs[i].name,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size2.toInt(),
                    child: Text(
                      dashboardController.mqsEnterprisePOCs[i].phoneNumber,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: PopupMenuButton<int>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: ColorConfig.textFieldBorderColor,
                      ),
                      iconSize: SizeConfig.size22,
                      onSelected: (value) {
                        if (value == 0) {
                          dashboardController.setMqsEntPOCForm(index: i);
                        } else if (value == 1) {
                          dashboardController.deleteMqsEntPOC(index: i);
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
      ],
    ),
  );
}

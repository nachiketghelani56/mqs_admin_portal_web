import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEmpEmailListWidget(
    {required DashboardController dashboardController}) {
  GlobalKey<FormState> entEmpEmailFormKey = GlobalKey<FormState>();
  return Form(
    key:entEmpEmailFormKey,
    child: Column(
      children: [
        titleWidget(
          title: StringConfig.dashboard.mqsEmployeeEmailList,
          showAddIcon: true,
        ).tap(() {
          dashboardController.showMqsEmpEmailList.value = true;
          dashboardController.clearMqsEmpEmailFields();
        }),
        if (dashboardController.showMqsEmpEmailList.value) ...[
          SizeConfig.size34.height,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.employeeEmailController,
                  label: StringConfig.dashboard.emailAddress,
                  hintText: StringConfig.dashboard.enterEmailAddress,
                  validator: (p0) => Validator.emailValidator(p0 ?? "",StringConfig.dashboard.emailAddressText),
                ),
              ),
            ],
          ),
          SizeConfig.size34.height,
          CustomTextField(
            controller: dashboardController.employeeNameController,
            label: StringConfig.dashboard.employeeName,
            hintText: StringConfig.dashboard.enterEmployeeName,
            validator: (p0) => Validator.emptyValidator(
                p0 ?? "", StringConfig.dashboard.employeeName.toLowerCase()),
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
                    dashboardController.clearMqsEmpEmailFields();
                    dashboardController.editMqsEmpEmailIndex.value = -1;
                    dashboardController.showMqsEmpEmailList.value = false;
                  },
                  isSelected: false,
                ),
              ),
              SizeConfig.size12.width,
              SizedBox(
                width: SizeConfig.size162,
                child: CustomButton(
                  btnText: dashboardController.editMqsEmpEmailIndex.value >= 0
                      ? StringConfig.dashboard.update
                      : StringConfig.dashboard.submit,
                  onTap: () {
                    if (entEmpEmailFormKey.currentState
                            ?.validate() ??
                        false) {
                      if (dashboardController.editMqsEmpEmailIndex.value >= 0) {
                        dashboardController.editMqsEmpEmail();
                      } else {
                        dashboardController.addMqsEmpEmail();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
        if (dashboardController.mqsEmployeeEmailList.isNotEmpty) ...[
          SizeConfig.size30.height,
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.headerDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    StringConfig.dashboard.email,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.dashboard.firstName,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.dashboard.mqsCommonLogin,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    StringConfig.dashboard.isSignedUp,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          for (int i = 0;
              i < dashboardController.mqsEmployeeEmailList.length;
              i++)
            Container(
              height: SizeConfig.size55,
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
              decoration:
                  i == dashboardController.mqsEmployeeEmailList.length - 1
                      ? FontTextStyleConfig.contentDecoration.copyWith(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(SizeConfig.size12),
                          ),
                        )
                      : FontTextStyleConfig.contentDecoration,
              child: Row(
                children: [
                  Expanded(
                    flex: SizeConfig.size4.toInt(),
                    child: Text(
                      dashboardController
                          .mqsEmployeeEmailList[i].mqsEmployeeEmail,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size3.toInt(),
                    child: Text(
                      dashboardController
                          .mqsEmployeeEmailList[i].mqsEmployeeName,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size3.toInt(),
                    child: Text(
                      "${dashboardController.mqsEmployeeEmailList[i].mqsCommonLogin.toString().capitalize}",
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size2.toInt(),
                    child: Text(
                      "${dashboardController.mqsEmployeeEmailList[i].mqsIsSignUp.toString().capitalize}",
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
                          dashboardController.setMqsEmpEmailForm(index: i);
                        } else if (value == 1) {
                          dashboardController.deleteMqsEmpEmial(index: i);
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

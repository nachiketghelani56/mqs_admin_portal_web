import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEmpEmailListWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEmployeeEmailList,
        showAddIcon: true,
      ).tap(() {
        dashboardController.showMqsEmpEmailList.value = true;
      }),
      if (dashboardController.showMqsEmpEmailList.value) ...[
        SizeConfig.size34.height,
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: dashboardController.emailController,
                label: StringConfig.dashboard.emailAddress,
                hintText: StringConfig.dashboard.enterEmailAddress,
              ),
            ),
          ],
        ),
        SizeConfig.size34.height,
        Row(
          children: [
            Expanded(
              child: CustomDropDown(
                label: StringConfig.dashboard.mqsCommonLogin,
                value: dashboardController.mqsCommonLogin.value,
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text(
                      StringConfig.dashboard.trueText,
                      style: FontTextStyleConfig.tableTextStyle,
                    ),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text(
                      StringConfig.dashboard.falseText,
                      style: FontTextStyleConfig.tableTextStyle,
                    ),
                  ),
                ],
                onChanged: (val) {
                  dashboardController.mqsCommonLogin.value = val;
                },
              ),
            ),
            SizeConfig.size24.width,
            Expanded(
              child: CustomDropDown(
                label: StringConfig.dashboard.isSignedUp,
                value: dashboardController.isSignedUp.value,
                items: [
                  DropdownMenuItem(
                    value: true,
                    child: Text(
                      StringConfig.dashboard.trueText,
                      style: FontTextStyleConfig.tableTextStyle,
                    ),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text(
                      StringConfig.dashboard.falseText,
                      style: FontTextStyleConfig.tableTextStyle,
                    ),
                  ),
                ],
                onChanged: (val) {
                  dashboardController.isSignedUp.value = val;
                },
              ),
            ),
          ],
        ),
        SizeConfig.size34.height,
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: dashboardController.firstNameController,
                label: StringConfig.dashboard.firstName,
                hintText: StringConfig.dashboard.enterName,
              ),
            ),
            SizeConfig.size24.width,
            Expanded(
              child: CustomTextField(
                controller: dashboardController.lastNameController,
                label: StringConfig.dashboard.lastName,
                hintText: StringConfig.dashboard.enterName,
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
                  dashboardController.showMqsEmpEmailList.value = false;
                },
                isSelected: false,
              ),
            ),
            SizeConfig.size12.width,
            SizedBox(
              width: SizeConfig.size162,
              child: CustomButton(
                btnText: StringConfig.dashboard.add,
                onTap: () {
                  dashboardController.showMqsEmpEmailList.value = false;
                },
              ),
            ),
          ],
        ),
      ],
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
                StringConfig.dashboard.mqsCommonLogin,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.firstName,
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
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.lastName,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
      for (int i = 0; i < 4; i++)
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: i == 3
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
                child: const Text(
                  'testuser546@gmail.com',
                  style: FontTextStyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: const Text(
                  'True',
                  style: FontTextStyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: const Text(
                  'Team',
                  style: FontTextStyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: const Text(
                  'True',
                  style: FontTextStyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: const Text(
                  'Board',
                  style: FontTextStyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                child: PopupMenuButton<int>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: ColorConfig.textFieldBorderColor,
                  ),
                  iconSize: SizeConfig.size22,
                  onSelected: (value) {},
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
                                    style: FontTextStyleConfig.tableTextStyle
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
  );
}

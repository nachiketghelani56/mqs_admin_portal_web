import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterprisePOCsWidget(
    {required DashboardController dashboardController}) {
  return Column(
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
              ),
            ),
          ],
        ),
        SizeConfig.size34.height,
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: dashboardController.pocNameController,
                label: StringConfig.dashboard.name,
                hintText: StringConfig.dashboard.enterName,
              ),
            ),
            SizeConfig.size24.width,
            Expanded(
              child: CustomTextField(
                controller: dashboardController.pocPhoneNumberController,
                label: StringConfig.dashboard.phoneNumber,
                hintText: StringConfig.dashboard.enterPhoneNumber,
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
                  dashboardController.showMqsEnterprisePOCs.value = false;
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
                  dashboardController.showMqsEnterprisePOCs.value = false;
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
        decoration: FontTextstyleConfig.headerDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                StringConfig.dashboard.address,
                style: FontTextstyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                StringConfig.dashboard.email,
                style: FontTextstyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.name,
                style: FontTextstyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.phoneNumber,
                style: FontTextstyleConfig.tableBottomTextStyle,
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
              ? FontTextstyleConfig.contentDecoration.copyWith(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(SizeConfig.size12),
                  ),
                )
              : FontTextstyleConfig.contentDecoration,
          child: Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: const Text(
                  'Test',
                  style: FontTextstyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: const Text(
                  'testuser546@gmail.com',
                  style: FontTextstyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: const Text(
                  'Test User',
                  style: FontTextstyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: const Text(
                  '6584536243',
                  style: FontTextstyleConfig.tableContentTextStyle,
                ),
              ),
              Expanded(
                child: PopupMenuButton<int>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: ColorConfig.textfieldBorderColor,
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
                                    style: FontTextstyleConfig.tableTextStyle
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

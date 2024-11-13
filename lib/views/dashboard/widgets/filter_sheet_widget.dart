import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_radio_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget filterSheetWidget({required DashboardController dashboardController}) {
  return Drawer(
    width: SizeConfig.size640,
    shape: const RoundedRectangleBorder(),
    child: SingleChildScrollView(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    StringConfig.dashboard.filter,
                    style: FontTextStyleConfig.tableBottomTextStyle
                        .copyWith(fontSize: SizeConfig.size26),
                  ),
                ),
                Image.asset(
                  ImageConfig.close,
                  height: SizeConfig.size28,
                ).tap(() {
                  Get.back();
                }),
              ],
            ),
            SizeConfig.size34.height,
            titleWidget(
              title: StringConfig.dashboard.filterByField,
              isShowContent: dashboardController.showFilterByField.value,
            ).tap(() {
              dashboardController.showFilterByField.value =
                  !dashboardController.showFilterByField.value;
            }),
            if (dashboardController.showFilterByField.value) ...[
              if (dashboardController.selectedFilterFieldIndex.value >= 0) ...[
                SizeConfig.size14.height,
                Container(
                  padding: const EdgeInsets.all(SizeConfig.size10),
                  decoration: FontTextStyleConfig.filterDecoration,
                  child: Row(
                    children: [
                      Container(
                        decoration: FontTextStyleConfig.optionDecoration,
                        padding: const EdgeInsets.all(SizeConfig.size10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              dashboardController.filterFields[
                                  dashboardController
                                      .selectedFilterFieldIndex.value],
                              style: FontTextStyleConfig.labelTextStyle
                                  .copyWith(color: ColorConfig.whiteColor),
                            ),
                            SizeConfig.size10.width,
                            Image.asset(
                              ImageConfig.close,
                              color: ColorConfig.whiteColor,
                              height: SizeConfig.size20,
                            ).tap(() {
                              dashboardController
                                  .selectedFilterFieldIndex.value = -1;
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
              SizeConfig.size14.height,
              Wrap(
                spacing: SizeConfig.size12,
                runSpacing: SizeConfig.size12,
                children: [
                  for (int i = 0;
                      i < dashboardController.filterFields.length;
                      i++)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConfig.size18,
                          vertical: SizeConfig.size6),
                      decoration: FontTextStyleConfig.subOptionDecoration,
                      child: Text(
                        dashboardController.filterFields[i],
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ).tap(() {
                      dashboardController.selectedFilterFieldIndex.value = i;
                    })
                ],
              ),
            ],
            SizeConfig.size30.height,
            titleWidget(
              title: StringConfig.dashboard.addCondition,
              isShowContent: dashboardController.showAddCondition.value,
            ).tap(() {
              dashboardController.showAddCondition.value =
                  !dashboardController.showAddCondition.value;
            }),
            if (dashboardController.showAddCondition.value) ...[
              SizeConfig.size14.height,
              CustomDropDown(
                items: [
                  for (int i = 0;
                      i < dashboardController.filterConditions.length;
                      i++)
                    DropdownMenuItem(
                      value: i,
                      child: Text(dashboardController.filterConditions[i]),
                    ),
                ],
                onChanged: (val) {
                  dashboardController.selectedConditionIndex.value = val;
                },
                label: StringConfig.dashboard.selectCondition,
              ),
              if (dashboardController.selectedConditionIndex.value >= 0) ...[
                SizeConfig.size14.height,
                CustomTextField(
                  controller: dashboardController.filterFieldController,
                  label: StringConfig.dashboard.enterValue,
                ),
              ],
            ],
            SizeConfig.size30.height,
            titleWidget(
              title: StringConfig.dashboard.sortResults,
              isShowContent: dashboardController.showSortResults.value,
            ).tap(() {
              dashboardController.showSortResults.value =
                  !dashboardController.showSortResults.value;
            }),
            if (dashboardController.showSortResults.value) ...[
              SizeConfig.size14.height,
              Row(
                children: [
                  CustomRadioWidget(
                    title: StringConfig.dashboard.ascending,
                    isSelected: dashboardController.isAsc.value,
                    onChanged: () {
                      dashboardController.isAsc.value = true;
                    },
                  ),
                  SizeConfig.size42.width,
                  CustomRadioWidget(
                    title: StringConfig.dashboard.descending,
                    isSelected: !dashboardController.isAsc.value,
                    onChanged: () {
                      dashboardController.isAsc.value = false;
                    },
                  ),
                ],
              ),
            ],
            SizeConfig.size55.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: SizeConfig.size156,
                  child: CustomButton(
                    btnText: StringConfig.dashboard.reset,
                    onTap: () {
                      dashboardController.resetFilter();
                      Get.back();
                    },
                    isSelected: false,
                  ),
                ),
                SizeConfig.size12.width,
                SizedBox(
                  width: SizeConfig.size156,
                  child: CustomButton(
                    btnText: StringConfig.dashboard.apply,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            )
          ],
        ).paddingAll(SizeConfig.size40),
      ),
    ),
  );
}

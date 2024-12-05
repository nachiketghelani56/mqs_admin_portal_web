import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                              dashboardController.selectedTabIndex.value == 0
                                  ? dashboardController.enterpriseKeyName(
                                      dashboardController.filterFields[
                                          dashboardController
                                              .selectedFilterFieldIndex.value])
                                  : dashboardController.userKeyName(
                                      dashboardController.filterFields[
                                          dashboardController
                                              .selectedFilterFieldIndex.value]),
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
                        dashboardController.selectedTabIndex.value == 0
                            ? dashboardController.enterpriseKeyName(
                                dashboardController.filterFields[i])
                            : dashboardController.userKeyName(
                                dashboardController.filterFields[i]),
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
                value: dashboardController.selectedConditionIndex.value >= 0
                    ? dashboardController.selectedConditionIndex.value
                    : null,
                items: [
                  for (int i = 0;
                      i < dashboardController.filterConditions.length;
                      i++)
                    DropdownMenuItem(
                      value: i,
                      child: Text(
                        dashboardController.filterConditions[i],
                        style: FontTextStyleConfig.textFieldTextStyle
                            .copyWith(fontSize: FontSizeConfig.fontSize16),
                      ),
                    ),
                ],
                onChanged: (val) {
                  dashboardController.selectedConditionIndex.value = val;
                  if (dashboardController.rows.isEmpty) {
                    dashboardController.addRow();
                  }
                },
                label: StringConfig.dashboard.selectCondition,
              ),
              if (dashboardController.selectedConditionIndex.value >= 0) ...[
                SizeConfig.size18.height,
                if (dashboardController.selectedConditionIndex.value == 6 ||
                    dashboardController.selectedConditionIndex.value == 7 ||
                    dashboardController.selectedConditionIndex.value == 9)
                  Text(
                    StringConfig.dashboard.enterUpValues,
                    style: FontTextStyleConfig.labelTextStyle
                        .copyWith(color: ColorConfig.subtitleColor),
                  ),
                SizeConfig.size10.height,
                ...List.generate(dashboardController.rows.length, (index) {
                  final row = dashboardController.rows[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: CustomDropDown(
                            label: "",
                            value: row.dataType,
                            items:
                                dashboardController.dataTypes.map((dataType) {
                              return DropdownMenuItem(
                                value: dataType,
                                child: Text(
                                  dataType,
                                  style: FontTextStyleConfig.textFieldTextStyle
                                      .copyWith(
                                          fontSize: FontSizeConfig.fontSize16),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                dashboardController.rows[index].textController
                                    .clear();
                                row.dataType = value;
                                dashboardController.rows[index] = row;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (row.dataType == "Boolean")
                          Flexible(
                            flex: 3,
                            child: CustomDropDown(
                              label: "",
                              value: row.selectedBoolean,
                              items: dashboardController.booleanValues
                                  .map((boolValue) {
                                return DropdownMenuItem(
                                  value: boolValue,
                                  child: Text(
                                    boolValue,
                                    style: FontTextStyleConfig
                                        .textFieldTextStyle
                                        .copyWith(
                                            fontSize:
                                                FontSizeConfig.fontSize16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  row.selectedBoolean = value;
                                  dashboardController.rows[index] = row;
                                }
                              },
                            ),
                          )
                        else
                          Flexible(
                            flex: 3,
                            child: CustomTextField(
                              controller: row.textController,
                              label: "",
                              padding: SizeConfig.size22,
                              inputFormatters: row.dataType ==
                                      StringConfig.dashboard.string
                                  ? []
                                  : [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                              border: dashboardController.validateInput(
                                          row.dataType,
                                          row.textController.text) !=
                                      null
                                  ? FontTextStyleConfig.borderDecoration
                                      .copyWith(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    )
                                  : FontTextStyleConfig.borderDecoration,
                              onChanged: (_) {
                                dashboardController.rows.refresh();
                              },
                            ),
                          ),
                        SizeConfig.size8.width,
                        if (dashboardController.selectedConditionIndex.value == 6 ||
                            dashboardController.selectedConditionIndex.value ==
                                7 ||
                            dashboardController.selectedConditionIndex.value ==
                                9)
                          GestureDetector(
                            onTap: () {
                              dashboardController.removeRow(index);
                            },
                            child: Image.asset(
                              ImageConfig.delete,
                              height: SizeConfig.size24,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                if (dashboardController.selectedConditionIndex.value == 6 ||
                    dashboardController.selectedConditionIndex.value == 7 ||
                    dashboardController.selectedConditionIndex.value == 9)
                  if (dashboardController.rows.length < 10) ...[
                    SizeConfig.size5.height,
                    TextButton.icon(
                      onPressed: dashboardController.addRow,
                      icon: const Icon(
                        Icons.add,
                        size: SizeConfig.size20,
                      ),
                      label: Text(
                        StringConfig.dashboard.addValue,
                        style: FontTextStyleConfig.labelTextStyle.copyWith(
                          color: ColorConfig.subtitleColor,
                          fontSize: FontSizeConfig.fontSize14,
                        ),
                      ),
                    ),
                  ]
              ],
            ],
            SizeConfig.size30.height,
            if (![
              6,
              7,
              8,
              9
            ].contains(dashboardController.selectedConditionIndex.value)) ...[
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
                      isAddCondition: dashboardController
                              .showAddCondition.value &&
                          dashboardController.selectedConditionIndex.value !=
                              -1,
                    ),
                    SizeConfig.size42.width,
                    CustomRadioWidget(
                      title: StringConfig.dashboard.descending,
                      isSelected: !dashboardController.isAsc.value,
                      onChanged: () {
                        dashboardController.isAsc.value = false;
                      },
                      isAddCondition: dashboardController
                              .showAddCondition.value &&
                          dashboardController.selectedConditionIndex.value !=
                              -1,
                    ),
                  ],
                ),
              ],
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
                      if (dashboardController.selectedFilterFieldIndex.value >=
                          0) {
                        dashboardController.applyFilter(
                            dashboardController.filterFields[dashboardController
                                .selectedFilterFieldIndex.value],
                            dashboardController.rows,
                            dashboardController.selectedConditionIndex.value);
                      }
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

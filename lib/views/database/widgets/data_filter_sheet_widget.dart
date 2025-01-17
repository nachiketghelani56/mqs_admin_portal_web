import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/controller/database_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_radio_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget dataFilterSheetWidget({required DatabaseController databaseController}) {
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
              isShowContent: databaseController.showFilterByField.value,
            ).tap(() {
              databaseController.showFilterByField.value =
                  !databaseController.showFilterByField.value;
            }),
            if (databaseController.showFilterByField.value) ...[
              if (databaseController.selectedFilterFieldIndex.value >= 0) ...[
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
                              databaseController.selectedTabIndex.value == 0
                                  ? databaseController.enterpriseKeyName()
                                  : databaseController.selectedTabIndex.value ==
                                          2
                                      ? databaseController.circleKeyName()
                                      : databaseController
                                          .userSubscriptionReceiptKeyName(),
                              //     : databaseController
                              //                 .selectedTabIndex.value ==
                              //             2
                              //         ? databaseController.circleKeyName()
                              //         : databaseController
                              //             .pathwayKeyName(),
                              style: FontTextStyleConfig.labelTextStyle
                                  .copyWith(color: ColorConfig.whiteColor),
                            ),
                            SizeConfig.size10.width,
                            Image.asset(
                              ImageConfig.close,
                              color: ColorConfig.whiteColor,
                              height: SizeConfig.size20,
                            ).tap(() {
                              databaseController
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
                      i < databaseController.filterFields.length;
                      i++)
                    if (databaseController.selectedTabIndex.value == 1) ...[
                      if (databaseController.userKeyName(index: i).isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SizeConfig.size18,
                              vertical: SizeConfig.size6),
                          decoration: FontTextStyleConfig.subOptionDecoration,
                          child: Text(
                            databaseController.userKeyName(index: i),
                            style: FontTextStyleConfig.tableContentTextStyle,
                          ),
                        ).tap(() {
                          databaseController.selectedFilterFieldIndex.value =
                              i;
                        })
                    ] else if (databaseController.selectedTabIndex.value ==
                        3) ...[
                      if (databaseController.filterFields[i] !=
                          StringConfig.pathway.mqsPathwayID)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SizeConfig.size18,
                              vertical: SizeConfig.size6),
                          decoration: FontTextStyleConfig.subOptionDecoration,
                          child: Text(
                            databaseController.pathwayKeyName(index: i),
                            style: FontTextStyleConfig.tableContentTextStyle,
                          ),
                        ).tap(() {
                          databaseController.selectedFilterFieldIndex.value =
                              i;
                        })
                    ] else
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SizeConfig.size18,
                            vertical: SizeConfig.size6),
                        decoration: FontTextStyleConfig.subOptionDecoration,
                        child: Text(
                          databaseController.selectedTabIndex.value == 0
                              ? databaseController.enterpriseKeyName(index: i)
                              : databaseController.selectedTabIndex.value == 2
                                  ? databaseController.circleKeyName(index: i)
                                  : databaseController
                                      .userSubscriptionReceiptKeyName(index: i),
                          style: FontTextStyleConfig.tableContentTextStyle,
                        ),
                      ).tap(() {
                        databaseController.selectedFilterFieldIndex.value = i;
                      })
                ],
              ),
            ],
            SizeConfig.size30.height,
            titleWidget(
              title: StringConfig.dashboard.addCondition,
              isShowContent: databaseController.showAddCondition.value,
            ).tap(() {
              databaseController.showAddCondition.value =
                  !databaseController.showAddCondition.value;
            }),
            if (databaseController.showAddCondition.value) ...[
              SizeConfig.size14.height,
              CustomDropDown(
                value: databaseController.selectedConditionIndex.value >= 0
                    ? databaseController.selectedConditionIndex.value
                    : null,
                items: [
                  for (int i = 0;
                      i < databaseController.filterConditions.length;
                      i++)
                    DropdownMenuItem(
                      value: i,
                      child: Text(
                        databaseController.filterConditions[i],
                        style: FontTextStyleConfig.textFieldTextStyle
                            .copyWith(fontSize: FontSizeConfig.fontSize16),
                      ),
                    ),
                ],
                onChanged: (val) {
                  databaseController.selectedConditionIndex.value = val;
                  if (databaseController.rows.isEmpty) {
                    databaseController.addRow();
                  }
                },
                label: StringConfig.dashboard.selectCondition,
              ),
              if (databaseController.selectedConditionIndex.value >= 0) ...[
                SizeConfig.size18.height,
                if (databaseController.selectedConditionIndex.value == 6 ||
                    databaseController.selectedConditionIndex.value == 7 ||
                    databaseController.selectedConditionIndex.value == 9)
                  Text(
                    StringConfig.dashboard.enterUpValues,
                    style: FontTextStyleConfig.labelTextStyle
                        .copyWith(color: ColorConfig.subtitleColor),
                  ),
                SizeConfig.size10.height,
                ...List.generate(databaseController.rows.length, (index) {
                  final row = databaseController.rows[index];
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
                                databaseController.dataTypes.map((dataType) {
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
                                databaseController.rows[index].textController
                                    .clear();
                                row.dataType = value;
                                databaseController.rows[index] = row;
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
                              items: databaseController.booleanValues
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
                                  databaseController.rows[index] = row;
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
                              border: databaseController.validateInput(
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
                                databaseController.rows.refresh();
                              },
                            ),
                          ),
                        SizeConfig.size8.width,
                        if (databaseController.selectedConditionIndex.value == 6 ||
                            databaseController.selectedConditionIndex.value ==
                                7 ||
                            databaseController.selectedConditionIndex.value ==
                                9)
                          GestureDetector(
                            onTap: () {
                              databaseController.removeRow(index);
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
                if (databaseController.selectedConditionIndex.value == 6 ||
                    databaseController.selectedConditionIndex.value == 7 ||
                    databaseController.selectedConditionIndex.value == 9)
                  if (databaseController.rows.length < 10) ...[
                    SizeConfig.size5.height,
                    TextButton.icon(
                      onPressed: databaseController.addRow,
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
            ].contains(databaseController.selectedConditionIndex.value)) ...[
              titleWidget(
                title: StringConfig.dashboard.sortResults,
                isShowContent: databaseController.showSortResults.value,
              ).tap(() {
                databaseController.showSortResults.value =
                    !databaseController.showSortResults.value;
              }),
              if (databaseController.showSortResults.value) ...[
                SizeConfig.size14.height,
                Row(
                  children: [
                    CustomRadioWidget(
                      title: StringConfig.dashboard.ascending,
                      isSelected: databaseController.isAsc.value,
                      onChanged: () {
                        databaseController.isAsc.value = true;
                      },
                      isAddCondition: databaseController
                              .showAddCondition.value &&
                          databaseController.selectedConditionIndex.value !=
                              -1,
                    ),
                    SizeConfig.size42.width,
                    CustomRadioWidget(
                      title: StringConfig.dashboard.descending,
                      isSelected: !databaseController.isAsc.value,
                      onChanged: () {
                        databaseController.isAsc.value = false;
                      },
                      isAddCondition: databaseController
                              .showAddCondition.value &&
                          databaseController.selectedConditionIndex.value !=
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
                      databaseController.resetFilter();
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
                      if (databaseController.selectedFilterFieldIndex.value >=
                          0) {
                        databaseController.applyFilter();
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

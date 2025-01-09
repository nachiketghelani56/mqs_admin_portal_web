import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterpriseDataEmpEmailListWidget(
    {required EnterpriseDataController enterpriseDataController,
    required BuildContext context}) {
  GlobalKey<FormState> entEmpEmailFormKey = GlobalKey<FormState>();
  return Form(
    key: entEmpEmailFormKey,
    child: context.width > SizeConfig.size1500
        ? Column(
            children: [
              titleWidget(
                title: StringConfig.dashboard.mqsEmployeeEmailList,
                showAddIcon: true,
              ).tap(() {
                enterpriseDataController.showMqsEmpEmailList.value = true;
                enterpriseDataController.clearMqsEmpEmailFields();
              }),
              if (enterpriseDataController.showMqsEmpEmailList.value) ...[
                SizeConfig.size34.height,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller:
                            enterpriseDataController.employeeEmailController,
                        label: StringConfig.dashboard.emailAddress,
                        hintText: StringConfig.dashboard.enterEmailAddress,
                        validator: (p0) => Validator.emailValidator(
                            p0 ?? "", StringConfig.dashboard.emailAddressText),
                      ),
                    ),
                    SizeConfig.size24.width,
                    Expanded(
                      child: CustomTextField(
                        controller:
                            enterpriseDataController.employeeNameController,
                        label: StringConfig.dashboard.employeeName,
                        hintText: StringConfig.dashboard.enterEmployeeName,
                        validator: (p0) => Validator.emptyValidator(p0 ?? "",
                            StringConfig.dashboard.employeeName.toLowerCase()),
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
                        value: enterpriseDataController.mqsCommonLogin.value,
                        items: enterpriseDataController.boolOptions,
                        onChanged: (value) {
                          enterpriseDataController.mqsCommonLogin.value = value;
                        },
                      ),
                    ),
                    SizeConfig.size24.width,
                    Expanded(child: Container()),
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
                          enterpriseDataController.clearMqsEmpEmailFields();
                          enterpriseDataController.editMqsEmpEmailIndex.value =
                              -1;
                          enterpriseDataController.showMqsEmpEmailList.value =
                              false;
                        },
                        isSelected: false,
                      ),
                    ),
                    SizeConfig.size12.width,
                    SizedBox(
                      width: SizeConfig.size162,
                      child: CustomButton(
                        btnText: enterpriseDataController
                                    .editMqsEmpEmailIndex.value >=
                                0
                            ? StringConfig.dashboard.update
                            : StringConfig.dashboard.submit,
                        onTap: () {
                          if (entEmpEmailFormKey.currentState?.validate() ??
                              false) {
                            if (enterpriseDataController
                                    .editMqsEmpEmailIndex.value >=
                                0) {
                              enterpriseDataController.editMqsEmpEmail();
                            } else {
                              enterpriseDataController.addMqsEmpEmail();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
              if (enterpriseDataController.mqsEmployeeEmailList.isNotEmpty) ...[
                SizeConfig.size30.height,
                Container(
                  height: SizeConfig.size55,
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
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
                    i < enterpriseDataController.mqsEmployeeEmailList.length;
                    i++)
                  Container(
                    height: SizeConfig.size55,
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size14),
                    decoration: i ==
                            enterpriseDataController
                                    .mqsEmployeeEmailList.length -
                                1
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
                            enterpriseDataController
                                .mqsEmployeeEmailList[i].mqsEmployeeEmail,
                            style: FontTextStyleConfig.tableContentTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: SizeConfig.size3.toInt(),
                          child: Text(
                            enterpriseDataController
                                .mqsEmployeeEmailList[i].mqsEmployeeName,
                            style: FontTextStyleConfig.tableContentTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: SizeConfig.size3.toInt(),
                          child: Text(
                            "${enterpriseDataController.mqsEmployeeEmailList[i].mqsCommonLogin.toString().capitalize}",
                            style: FontTextStyleConfig.tableContentTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: SizeConfig.size2.toInt(),
                          child: Text(
                            "${enterpriseDataController.mqsEmployeeEmailList[i].mqsIsSignUp.toString().capitalize}",
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
                                enterpriseDataController.setMqsEmpEmailForm(
                                    index: i);
                              } else if (value == 1) {
                                enterpriseDataController.deleteMqsEmpEmial(
                                    index: i);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                for (int i = 0;
                                    i < enterpriseDataController.options.length;
                                    i++)
                                  PopupMenuItem<int>(
                                    value: i,
                                    child: Container(
                                      width: SizeConfig.size140,
                                      padding: const EdgeInsets.all(
                                          SizeConfig.size8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            enterpriseDataController
                                                .options[i].icon,
                                            height: SizeConfig.size24,
                                          ),
                                          SizeConfig.size15.width,
                                          Expanded(
                                            child: Text(
                                              enterpriseDataController
                                                  .options[i].title,
                                              style: FontTextStyleConfig
                                                  .tableTextStyle
                                                  .copyWith(
                                                      color:
                                                          enterpriseDataController
                                                              .options[i]
                                                              .color),
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
          )
        : Column(
            children: [
              titleWidget(
                title: StringConfig.dashboard.mqsEmployeeEmailList,
                showAddIcon: true,
              ).tap(() {
                enterpriseDataController.showMqsEmpEmailList.value = true;
                enterpriseDataController.clearMqsEmpEmailFields();
              }),
              if (enterpriseDataController.showMqsEmpEmailList.value) ...[
                SizeConfig.size34.height,
                CustomTextField(
                  controller:
                      enterpriseDataController.employeeEmailController,
                  label: StringConfig.dashboard.emailAddress,
                  hintText: StringConfig.dashboard.enterEmailAddress,
                  validator: (p0) => Validator.emailValidator(
                      p0 ?? "", StringConfig.dashboard.emailAddressText),
                ),
                SizeConfig.size34.height,
                CustomTextField(
                  controller:
                      enterpriseDataController.employeeNameController,
                  label: StringConfig.dashboard.employeeName,
                  hintText: StringConfig.dashboard.enterEmployeeName,
                  validator: (p0) => Validator.emptyValidator(p0 ?? "",
                      StringConfig.dashboard.employeeName.toLowerCase()),
                ),
                SizeConfig.size34.height,
                CustomDropDown(
                  label: StringConfig.dashboard.mqsCommonLogin,
                  value: enterpriseDataController.mqsCommonLogin.value,
                  items: enterpriseDataController.boolOptions,
                  onChanged: (value) {
                    enterpriseDataController.mqsCommonLogin.value = value;
                  },
                ),
                SizeConfig.size18.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: SizeConfig.size120,
                      child: CustomButton(
                        btnText: StringConfig.dashboard.cancel,
                        onTap: () {
                          enterpriseDataController.clearMqsEmpEmailFields();
                          enterpriseDataController.editMqsEmpEmailIndex.value =
                              -1;
                          enterpriseDataController.showMqsEmpEmailList.value =
                              false;
                        },
                        isSelected: false,
                      ),
                    ),
                    SizeConfig.size12.width,
                    SizedBox(
                      width: SizeConfig.size120,
                      child: CustomButton(
                        btnText: enterpriseDataController
                                    .editMqsEmpEmailIndex.value >=
                                0
                            ? StringConfig.dashboard.update
                            : StringConfig.dashboard.submit,
                        onTap: () {
                          if (entEmpEmailFormKey.currentState?.validate() ??
                              false) {
                            if (enterpriseDataController
                                    .editMqsEmpEmailIndex.value >=
                                0) {
                              enterpriseDataController.editMqsEmpEmail();
                            } else {
                              enterpriseDataController.addMqsEmpEmail();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
              if (enterpriseDataController.mqsEmployeeEmailList.isNotEmpty) ...[
                SizeConfig.size30.height,
                Container(
                  height: SizeConfig.size55,
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
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
                    i < enterpriseDataController.mqsEmployeeEmailList.length;
                    i++)
                  Container(
                    height: SizeConfig.size55,
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size14),
                    decoration: i ==
                            enterpriseDataController
                                    .mqsEmployeeEmailList.length -
                                1
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
                            enterpriseDataController
                                .mqsEmployeeEmailList[i].mqsEmployeeEmail,
                            style: FontTextStyleConfig.tableContentTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: SizeConfig.size3.toInt(),
                          child: Text(
                            enterpriseDataController
                                .mqsEmployeeEmailList[i].mqsEmployeeName,
                            style: FontTextStyleConfig.tableContentTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: SizeConfig.size3.toInt(),
                          child: Text(
                            "${enterpriseDataController.mqsEmployeeEmailList[i].mqsCommonLogin.toString().capitalize}",
                            style: FontTextStyleConfig.tableContentTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: SizeConfig.size2.toInt(),
                          child: Text(
                            "${enterpriseDataController.mqsEmployeeEmailList[i].mqsIsSignUp.toString().capitalize}",
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
                                enterpriseDataController.setMqsEmpEmailForm(
                                    index: i);
                              } else if (value == 1) {
                                enterpriseDataController.deleteMqsEmpEmial(
                                    index: i);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                for (int i = 0;
                                    i < enterpriseDataController.options.length;
                                    i++)
                                  PopupMenuItem<int>(
                                    value: i,
                                    child: Container(
                                      width: SizeConfig.size140,
                                      padding: const EdgeInsets.all(
                                          SizeConfig.size8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            enterpriseDataController
                                                .options[i].icon,
                                            height: SizeConfig.size24,
                                          ),
                                          SizeConfig.size15.width,
                                          Expanded(
                                            child: Text(
                                              enterpriseDataController
                                                  .options[i].title,
                                              style: FontTextStyleConfig
                                                  .tableTextStyle
                                                  .copyWith(
                                                      color:
                                                          enterpriseDataController
                                                              .options[i]
                                                              .color),
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

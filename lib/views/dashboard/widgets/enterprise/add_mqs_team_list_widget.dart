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

Widget addMqsTeamListWidget(
    {required DashboardController dashboardController}) {
  return Form(
    key: dashboardController.entTeamFormKey,
    child: Column(
      children: [
        titleWidget(
          title: StringConfig.dashboard.mqsTeamList,
          showAddIcon: true,
        ).tap(() {
          dashboardController.showMqsTeamList.value = true;
          dashboardController.clearMqsTeamFields();
        }),
        if (dashboardController.showMqsTeamList.value) ...[
          SizeConfig.size34.height,
          CustomTextField(
            controller: dashboardController.teamNameController,
            label: StringConfig.dashboard.teamName,
            hintText: StringConfig.dashboard.enterTeamName,
            validator: (p0) => Validator.emptyValidator(
                p0 ?? "", StringConfig.dashboard.teamName.toLowerCase()),
          ),
          SizeConfig.size34.height,
          CustomTextField(
            controller: dashboardController.teamEmailController,
            label: StringConfig.dashboard.teamEmailAddress,
            hintText: StringConfig.dashboard.enterEmailAddress,
            validator: (p0) => Validator.emailValidator(p0 ?? "",StringConfig.dashboard.emailAddressText),
          ),
          SizeConfig.size34.height,
          CustomTextField(
            controller: dashboardController.teamMemberLimitController,
            label: StringConfig.dashboard.teamMemberLimit,
            hintText: StringConfig.dashboard.enterTeamMemberLimit,
            validator: (p0) => Validator.emptyValidator(
                p0 ?? "", StringConfig.dashboard.teamMemberLimit.toLowerCase()),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: const TextInputType.numberWithOptions(
                decimal: false, signed: false),
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  visualDensity:
                      const VisualDensity(vertical: -SizeConfig.size4),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_drop_up),
                  onPressed: () {
                    int currentValue = dashboardController
                            .teamMemberLimitController.text.isEmpty
                        ? 0
                        : int.parse(
                            dashboardController.teamMemberLimitController.text);
                    if (currentValue > 0) {
                      currentValue++;
                      dashboardController.teamMemberLimitController.text =
                          (currentValue).toString();
                    }
                    // incrementing value
                  },
                ),
                IconButton(
                  visualDensity: const VisualDensity(vertical: -4),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    int currentValue = dashboardController
                            .teamMemberLimitController.text.isEmpty
                        ? 0
                        : int.parse(
                            dashboardController.teamMemberLimitController.text);
                    if (currentValue > 1) {
                      currentValue--;
                      dashboardController.teamMemberLimitController.text =
                          (currentValue).toString();
                    }
                  },
                ),
              ],
            ),
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
                    dashboardController.clearMqsTeamFields();
                    dashboardController.editMqsTeamIndex.value = -1;
                    dashboardController.showMqsTeamList.value = false;
                  },
                  isSelected: false,
                ),
              ),
              SizeConfig.size12.width,
              SizedBox(
                width: SizeConfig.size162,
                child: CustomButton(
                  btnText: dashboardController.editMqsTeamIndex.value >= 0
                      ? StringConfig.dashboard.update
                      : StringConfig.dashboard.submit,
                  onTap: () {
                    if (dashboardController.entTeamFormKey.currentState
                            ?.validate() ??
                        false) {
                      if (dashboardController.editMqsTeamIndex.value >= 0) {
                        dashboardController.editMqsTeam();
                      } else {
                        dashboardController.addMqsTeam();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
        if (dashboardController.mqsTeamList.isNotEmpty) ...[
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
                    StringConfig.dashboard.teamName,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.dashboard.teamEmailAddress,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.dashboard.teamMemberLimit,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    StringConfig.dashboard.isEnable,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          for (int i = 0; i < dashboardController.mqsTeamList.length; i++)
            Container(
              height: SizeConfig.size55,
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
              decoration: i == dashboardController.mqsTeamList.length - 1
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
                      dashboardController.mqsTeamList[i].mqsTeamName,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size3.toInt(),
                    child: Text(
                      dashboardController.mqsTeamList[i].mqsTeamEmail,
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size3.toInt(),
                    child: Text(
                      "${dashboardController.mqsTeamList[i].mqsTeamMembersLimit}",
                      style: FontTextStyleConfig.tableContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.size2.toInt(),
                    child: Text(
                      "${dashboardController.mqsTeamList[i].mqsIsEnable.toString().capitalize}",
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
                          dashboardController.setMqsTeamForm(index: i);
                        } else if (value == 1) {
                          dashboardController.deleteMqsTeam(index: i);
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

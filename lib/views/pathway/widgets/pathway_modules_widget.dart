import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/learn_activity_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/practice_activity_detail_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget pathwayModulesWidget({required PathwayController pathwayController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.pathway.modules,
        isShowContent: pathwayController.showModules.value,
      ).tap(() {
        pathwayController.showModules.value =
            !pathwayController.showModules.value;
        pathwayController.moduleIndex.value = -1;
      }),
      if (pathwayController.showModules.value) ...[
        SizeConfig.size10.height,
        for (int i = 0; i < pathwayController.modules.length; i++)
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: SizeConfig.size12, horizontal: SizeConfig.size12),
                decoration: pathwayController.moduleIndex.value != i
                    ? FontTextStyleConfig.detailBottomDecoration
                    : null,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pathwayController.modules[i].moduleTitle,
                        style: FontTextStyleConfig.tableBottomTextStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      pathwayController.moduleIndex.value == i
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: ColorConfig.primaryColor,
                    ),
                  ],
                ),
              ).tap(() {
                if (pathwayController.moduleIndex.value == i) {
                  pathwayController.moduleIndex.value = -1;
                } else {
                  pathwayController.moduleIndex.value = i;
                }
                pathwayController.showLearnActivty.value = false;
                pathwayController.showPracActivity.value = false;
              }),
              if (pathwayController.moduleIndex.value == i)
                Container(
                  padding: const EdgeInsets.only(bottom: SizeConfig.size12),
                  decoration: FontTextStyleConfig.detailBottomDecoration,
                  child: Column(
                    children: [
                      SizeConfig.size12.height,
                      keyValueRowWidget(
                        key: StringConfig.pathway.moduleID,
                        value: pathwayController.modules[i].id,
                        isFirst: true,
                      ),
                      keyValueRowWidget(
                        key: StringConfig.pathway.moduleTitle,
                        value: pathwayController.modules[i].moduleTitle,
                      ),
                      keyValueRowWidget(
                        key: StringConfig.pathway.moduleSubtitle,
                        value: pathwayController.modules[i].mqsModuleSubtitle,
                      ),
                      keyValueRowWidget(
                        key: StringConfig.pathway.moduleTileImage,
                        value: pathwayController.modules[i].moduleTileImage,
                        isImage: true,
                      ),
                      keyValueRowWidget(
                        key: StringConfig.pathway.moduleStatus,
                        value:
                            "${pathwayController.modules[i].mqsPWModuleStatus}",
                      ),
                      keyValueRowWidget(
                        key: StringConfig.pathway.completionDate,
                        value: pathwayController
                                .modules[i].mqsModuleCompletionDate.isNotEmpty
                            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                                .format(DateTime.parse(pathwayController
                                    .modules[i].mqsModuleCompletionDate))
                            : pathwayController
                                .modules[i].mqsModuleCompletionDate,
                      ),
                      keyValueRowWidget(
                        key: StringConfig.pathway.learnActivity,
                        widget: Icon(
                          pathwayController.showLearnActivty.value
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: ColorConfig.primaryColor,
                        ).centerRight,
                        onTap: () {
                          pathwayController.showLearnActivty.value =
                              !pathwayController.showLearnActivty.value;
                          pathwayController.learnActIndex.value = -1;
                        },
                        child: learnActivityDetailWidget(
                            pathwayController: pathwayController, index: i),
                      ),
                      keyValueRowWidget(
                        key: StringConfig.pathway.practiceActivity,
                        widget: Icon(
                          pathwayController.showPracActivity.value
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: ColorConfig.primaryColor,
                        ).centerRight,
                        isLast: true,
                        onTap: () {
                          pathwayController.showPracActivity.value =
                              !pathwayController.showPracActivity.value;
                          pathwayController.pracActIndex.value = -1;
                        },
                        child: practiceActivityDetailWidget(
                            pathwayController: pathwayController, index: i),
                      ),
                    ],
                  ),
                ),
            ],
          ),
      ],
    ],
  );
}

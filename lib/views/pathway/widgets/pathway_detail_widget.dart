import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget pathwayDetailWidget({required PathwayController pathwayController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(
            title: StringConfig.pathway.pathwayInformation,
            showArrowIcon: false,
          ),
          SizeConfig.size10.height,
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayID,
            value: pathwayController.pathwayDetail.id,
            isFirst: true,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayTitle,
            value: pathwayController.pathwayDetail.mqsPathwayTitle,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwaySubtitle,
            value: pathwayController.pathwayDetail.mqsPathwaySubtitle,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayType,
            value: pathwayController.pathwayDetail.mqsPathwayType,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayImage,
            value: pathwayController.pathwayDetail.mqsPathwayImage,
            isImage: true,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayIntroImage,
            value: pathwayController.pathwayDetail.mqsPathwayIntroImage,
            isImage: true,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayTileImage,
            value: pathwayController.pathwayDetail.mqsPathwayTileImage,
            isImage: true,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.aboutPathway,
            value: pathwayController.pathwayDetail.mqsAboutPathway,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.learningObj,
            value: pathwayController.pathwayDetail.mqsLearningObj,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.moduleCount,
            value: "${pathwayController.pathwayDetail.mqsModuleCount}",
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayCoachInstructions,
            value: pathwayController.pathwayDetail.mqsPathwayCoachInstructions,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayDep,
            value: pathwayController.pathwayDetail.mqsPathwayDep.join(", "),
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayDuration,
            value: pathwayController.pathwayDetail.mqsPathwayDuration,
          ),
          keyValueRowWidget(
            key: StringConfig.pathway.pathwayLevel,
            value: "${pathwayController.pathwayDetail.mqsPathwayLevel}",
            isLast: true,
          ),
          SizeConfig.size34.height,
          titleWidget(
            title: StringConfig.pathway.modules,
            isShowContent: pathwayController.showModules.value,
          ).tap(() {
            pathwayController.showModules.value =
                !pathwayController.showModules.value;
          }),
          if (pathwayController.showModules.value) ...[
            SizeConfig.size10.height,
            for (int i = 0; i < pathwayController.modules.length; i++)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: SizeConfig.size12,
                        horizontal: SizeConfig.size12),
                    decoration: !pathwayController.moduleIndexes.contains(i)
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
                          pathwayController.moduleIndexes.contains(i)
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: ColorConfig.primaryColor,
                        ),
                      ],
                    ),
                  ).tap(() {
                    if (pathwayController.moduleIndexes.contains(i)) {
                      pathwayController.moduleIndexes.remove(i);
                    } else {
                      pathwayController.moduleIndexes.add(i);
                    }
                  }),
                  if (pathwayController.moduleIndexes.contains(i))
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
                            value:
                                pathwayController.modules[i].mqsModuleSubtitle,
                          ),
                          keyValueRowWidget(
                            key: StringConfig.pathway.moduleTileImage,
                            value: pathwayController.modules[i].moduleTileImage,
                            isImage: true,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
          ],
        ],
      ),
    ),
  );
}

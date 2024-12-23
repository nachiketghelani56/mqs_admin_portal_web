import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_modules_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
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
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayID,
            value: pathwayController.pathwayDetail.id,
            isFirst: true,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayTitle,
            value: pathwayController.pathwayDetail.mqsPathwayTitle,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwaySubtitle,
            value: pathwayController.pathwayDetail.mqsPathwaySubtitle,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayType,
            value: pathwayController.pathwayDetail.mqsPathwayType,
          ),
          if (pathwayController.pathwayDetail.mqsPathwayImage.isNotEmpty)
            keyValueWrapperWidget(
              key: StringConfig.pathway.pathwayImage,
              value: pathwayController.pathwayDetail.mqsPathwayImage,
              isImage: true,
            ),
          if (pathwayController.pathwayDetail.mqsPathwayIntroImage.isNotEmpty)
            keyValueWrapperWidget(
              key: StringConfig.pathway.pathwayIntroImage,
              value: pathwayController.pathwayDetail.mqsPathwayIntroImage,
              isImage: true,
            ),
          if (pathwayController.pathwayDetail.mqsPathwayTileImage.isNotEmpty)
            keyValueWrapperWidget(
              key: StringConfig.pathway.pathwayTileImage,
              value: pathwayController.pathwayDetail.mqsPathwayTileImage,
              isImage: true,
            ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.aboutPathway,
            value: pathwayController.pathwayDetail.mqsAboutPathway,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.learningObj,
            value: pathwayController.pathwayDetail.mqsLearningObj,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.moduleCount,
            value: "${pathwayController.pathwayDetail.mqsModuleCount}",
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayCoachInstructions,
            value: pathwayController.pathwayDetail.mqsPathwayCoachInstructions,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayDep,
            value: pathwayController.pathwayDetail.mqsPathwayDep.join(", "),
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayDuration,
            value: pathwayController.pathwayDetail.mqsPathwayDuration,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayStatus,
            value: "${pathwayController.pathwayDetail.mqsPathwayStatus}",
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.pathwayLevel,
            value: "${pathwayController.pathwayDetail.mqsPathwayLevel}",
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.userId,
            value: pathwayController.pathwayDetail.mqsUserID,
          ),
          keyValueWrapperWidget(
            key: StringConfig.pathway.completionDate,
            value: pathwayController
                    .pathwayDetail.mqsPathwayCompletionDate.isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(pathwayController
                        .pathwayDetail.mqsPathwayCompletionDate))
                : pathwayController.pathwayDetail.mqsPathwayCompletionDate,
            isLast: true,
          ),
          if (pathwayController
                  .pathwayDetail.mqsPathwayDetail?.mqsModules.isNotEmpty ??
              false) ...[
            SizeConfig.size34.height,
            pathwayModulesWidget(pathwayController: pathwayController),
          ],
        ],
      ),
    ),
  );
}

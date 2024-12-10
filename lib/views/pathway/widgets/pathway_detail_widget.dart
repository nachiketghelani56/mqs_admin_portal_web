import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_modules_widget.dart';
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
          pathwayModulesWidget(pathwayController: pathwayController),
        ],
      ),
    ),
  );
}

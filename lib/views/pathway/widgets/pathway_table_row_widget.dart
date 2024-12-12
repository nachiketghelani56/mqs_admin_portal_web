import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_delete_dialog_widget.dart';

Widget pathwayTableRowWidget({
  required PathwayController pathwayController,
  required bool isSelected,
  required BuildContext context,
  required int index,
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.cardDecoration.copyWith(
      borderRadius: BorderRadius.circular(SizeConfig.size0),
      color: isSelected ? ColorConfig.bg2Color : null,
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          child: Text(
            pathwayController.searchedPathway[index].mqsPathwayTitle,
            overflow: TextOverflow.ellipsis,
            style: FontTextStyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          child: Text(
            pathwayController.searchedPathway[index].mqsPathwayType,
            overflow: TextOverflow.ellipsis,
            style: FontTextStyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                ImageConfig.eyeOpened,
                height: SizeConfig.size24,
              ).tap(() {
                pathwayController.isAdd.value = false;
                pathwayController.isEdit.value = false;
                pathwayController.viewIndex.value = index;
                pathwayController.showModules.value = false;
                pathwayController.moduleIndexes.clear();
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.pathwayDetail);
                }
              }),
              Image.asset(
                ImageConfig.edit,
                height: SizeConfig.size24,
              ).tap(() {
                pathwayController.clearAllFields();
                pathwayController.viewIndex.value = index;
                pathwayController.isAdd.value = false;
                pathwayController.isEdit.value = true;
                pathwayController.showPathwayDep.value = false;
                pathwayController.showModules.value = false;
                pathwayController.setPathwayForm();
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.addPathway);
                }
              }),
              Image.asset(
                ImageConfig.delete,
                height: SizeConfig.size24,
              ).tap(() {
                pathwayController.viewIndex.value = index;
                pathwayDeleteDialogWidget(
                  context: context,
                  pathwayController: pathwayController,
                  docId: pathwayController.searchedPathway[index].docId,
                );
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

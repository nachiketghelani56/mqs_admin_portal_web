import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget pathwayTopButtonsWidget(
    {required PathwayController pathwayController,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required BuildContext context}) {
  return context.width > SizeConfig.size1885
      ? Row(
          children: [
            CustomPrefixButton(
              prefixIcon: ImageConfig.filter,
              btnText: StringConfig.dashboard.filter,
              padding: SizeConfig.size15,
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            SearchTextField(
              controller: pathwayController.searchController,
              hintText: StringConfig.pathway.searchByTitleOrType,
              onChanged: (p0) {
                pathwayController.searchPathway();
              },
            ),
            const Spacer(),
            SizeConfig.size12.width,
            // CustomIconButton(
            //   icon: ImageConfig.import,
            //   onTap: () {
            //     pathwayController.importPathway();
            //   },
            // ),
            // SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {
                pathwayController.exportPathway();
              },
            ),
            // SizeConfig.size12.width,
            // CustomPrefixButton(
            //   prefixIcon: ImageConfig.add,
            //   padding: SizeConfig.size15,
            //   btnText: StringConfig.pathway.addPathway,
            //   onTap: () {
            //     pathwayController.isEdit.value = false;
            //     pathwayController.isAdd.value = true;
            //     pathwayController.clearAllFields();
            //     if (context.width < SizeConfig.size1500) {
            //       Get.toNamed(AppRoutes.addPathway);
            //     }
            //   },
            // ),
          ],
        )
      : Row(
          children: [
            CustomIconButton(
              icon: ImageConfig.filter,
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            SearchTextField(
              controller: pathwayController.searchController,
              hintText: StringConfig.pathway.searchByTitleOrType,
              onChanged: (p0) {
                pathwayController.searchPathway();
              },
            ),
            const Spacer(),
            // CustomIconButton(
            //   icon: ImageConfig.import,
            //   onTap: () {
            //     pathwayController.importPathway();
            //   },
            // ),
            // SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {
                pathwayController.exportPathway();
              },
            ),
            // SizeConfig.size12.width,
            // CustomIconButton(
            //   icon: ImageConfig.add,
            //   onTap: () {
            //     pathwayController.isEdit.value = false;
            //     pathwayController.isAdd.value = true;
            //     pathwayController.clearAllFields();
            //     if (context.width < SizeConfig.size1500) {
            //       Get.toNamed(AppRoutes.addPathway);
            //     }
            //   },
            // ),
          ],
        );
}

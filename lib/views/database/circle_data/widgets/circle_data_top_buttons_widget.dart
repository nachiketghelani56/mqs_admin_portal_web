import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget circleDataTopButtonsWidget({
  required CircleDataController circleDataController,
  required MqsDashboardController mqsDashboardController,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required BuildContext context,
}) {
  return context.width > SizeConfig.size1800
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

            if (circleDataController.circle.isNotEmpty)
              SearchTextField(
                controller: circleDataController.searchController,
                hintText: StringConfig.dashboard.searchByNameTitle,
                onChanged: (p0) {
                  circleDataController.searchCircle();
                },
              ),
            const Spacer(),

            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                circleDataController.importCircle();
              },
            ),
            SizeConfig.size12.width,

            if (circleDataController.circle.isNotEmpty)
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  circleDataController.searchController.clear();
                  circleDataController.exportCircle();
                },
              ),
            // if (filterWidget != null) ...[
            //   SizeConfig.size12.width,
            //   filterWidget
            // ],

            SizeConfig.size12.width,
            CustomPrefixButton(
              prefixIcon: ImageConfig.add,
              padding: SizeConfig.size15,
              btnText: StringConfig.circle.addCircle,
              onTap: () {
                circleDataController.isEdit.value = false;
                circleDataController.isAdd.value = true;
                circleDataController.showHashTag.value = false;
                circleDataController.clearAllFields();
                mqsDashboardController.circleStatus.value = "add_circle";
                // if (context.width < SizeConfig.size1500) {
                //   Get.toNamed(AppRoutes.addCircle);
                // }
              },
            ),
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

            if (circleDataController.circle.isNotEmpty)
              SearchTextField(
                controller: circleDataController.searchController,
                hintText: StringConfig.dashboard.searchByNameTitle,
                onChanged: (p0) {
                  circleDataController.searchCircle();
                },
              ),
            const Spacer(),

            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                circleDataController.importCircle();
              },
            ),
            SizeConfig.size12.width,

            if (circleDataController.circle.isNotEmpty)
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  circleDataController.searchController.clear();
                  circleDataController.exportCircle();
                },
              ),
            // if (filterWidget != null) ...[
            //   SizeConfig.size12.width,
            //   filterWidget
            // ],

            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.add,
              onTap: () {
                circleDataController.isEdit.value = false;
                circleDataController.isAdd.value = true;
                circleDataController.showHashTag.value = false;
                circleDataController.clearAllFields();
                mqsDashboardController.circleStatus.value = "add_circle";
                // if (context.width < SizeConfig.size1500) {
                //   Get.toNamed(AppRoutes.addCircle);
                // }
              },
            ),
          ],
        );
}

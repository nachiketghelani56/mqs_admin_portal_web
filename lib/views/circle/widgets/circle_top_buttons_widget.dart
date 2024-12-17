
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget circleTopButtonsWidget({
  required CircleController circleController,
  ReportingController? reportingController,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required BuildContext context,
  Widget? filterWidget,
}) {
  return context.width > SizeConfig.size1800
      ? Row(
          children: [
            if (!Get.currentRoute
                .startsWith(AppRoutes.circleSummaryDetailScreen)) ...[
              CustomPrefixButton(
                prefixIcon: ImageConfig.filter,
                btnText: StringConfig.dashboard.filter,
                padding: SizeConfig.size15,
                onTap: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
              ),
              SizeConfig.size12.width,
            ],
            SearchTextField(
              controller: circleController.searchController,
              hintText: StringConfig.dashboard.searchByNameTitle,
              onChanged: (p0) {
                if (Get.currentRoute
                    .startsWith(AppRoutes.circleSummaryDetailScreen))
                  {
                    circleController.searchCircle(status: "type");
                  }else{
                  circleController.searchCircle();
                }

              },
            ),
            const Spacer(),
            if (!Get.currentRoute
                .startsWith(AppRoutes.circleSummaryDetailScreen)) ...[
              SizeConfig.size12.width,
              CustomIconButton(
                icon: ImageConfig.import,
                onTap: () {
                  circleController.importCircle();
                },
              ),
              SizeConfig.size12.width,
            ],
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {

                if (Get.currentRoute
                    .startsWith(AppRoutes.circleSummaryDetailScreen)){
                  circleController.exportCircle(status: "type");
                }else{
                  circleController.exportCircle();
                }

              },
            ),
            if (filterWidget != null) ...[
              SizeConfig.size12.width,
              filterWidget
            ],
            if (!Get.currentRoute
                .startsWith(AppRoutes.circleSummaryDetailScreen)) ...[
              SizeConfig.size12.width,
              CustomPrefixButton(
                prefixIcon: ImageConfig.add,
                padding: SizeConfig.size15,
                btnText: StringConfig.circle.addCircle,
                onTap: () {
                  circleController.isEdit.value = false;
                  circleController.isAdd.value = true;
                  circleController.showHashTag.value = false;
                  circleController.clearAllFields();
                  if (context.width < SizeConfig.size1500) {
                    Get.toNamed(AppRoutes.addCircle);
                  }
                },
              ),
            ],
          ],
        )
      : Row(
          children: [
            if (!Get.currentRoute
                .startsWith(AppRoutes.circleSummaryDetailScreen)) ...[
              CustomIconButton(
                icon: ImageConfig.filter,
                onTap: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
              ),
              SizeConfig.size12.width,
            ],
            SearchTextField(
              controller: circleController.searchController,
              hintText: StringConfig.dashboard.searchByNameTitle,
              onChanged: (p0) {
                if (Get.currentRoute
                    .startsWith(AppRoutes.circleSummaryDetailScreen))
                {
                  circleController.searchCircle(status: "type");
                }else{
                  circleController.searchCircle();
                }
              },
            ),
            const Spacer(),
            if (!Get.currentRoute
                .startsWith(AppRoutes.circleSummaryDetailScreen)) ...[
              CustomIconButton(
                icon: ImageConfig.import,
                onTap: () {
                  circleController.importCircle();
                },
              ),
              SizeConfig.size12.width,
            ],
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {
                if (Get.currentRoute
                    .startsWith(AppRoutes.circleSummaryDetailScreen)){
                  circleController.exportCircle(status: "type");
                }else{
                  circleController.exportCircle();
                }
              },
            ),
            if (filterWidget != null) ...[
              SizeConfig.size12.width,
              filterWidget
            ],
            if (!Get.currentRoute
                .startsWith(AppRoutes.circleSummaryDetailScreen)) ...[
              SizeConfig.size12.width,
              CustomIconButton(
                icon: ImageConfig.add,
                onTap: () {
                  circleController.isEdit.value = false;
                  circleController.isAdd.value = true;
                  circleController.showHashTag.value = false;
                  circleController.clearAllFields();
                  if (context.width < SizeConfig.size1500) {
                    Get.toNamed(AppRoutes.addCircle);
                  }
                },
              ),
            ],
          ],
        );
}

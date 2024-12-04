import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget circleTopButtonsWidget(
    {required CircleController circleController,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required BuildContext context}) {
  return context.width > SizeConfig.size1800
      ? Row(
          children: [
            // CustomPrefixButton(
            //   prefixIcon: ImageConfig.filter,
            //   btnText: StringConfig.dashboard.filter,
            //   padding: SizeConfig.size15,
            //   onTap: () {
            //     scaffoldKey.currentState?.openEndDrawer();
            //   },
            // ),
            // SizeConfig.size12.width,
            SearchTextField(
              controller: circleController.searchController,
              hintText: StringConfig.dashboard.searchByNameTitle,
              onChanged: (p0) {
                circleController.searchCircle();
              },
            ),
            const Spacer(),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {
                circleController.exportCircle();
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
            SearchTextField(
              controller: circleController.searchController,
              hintText: StringConfig.dashboard.searchByNameTitle,
              onChanged: (p0) {
                circleController.searchCircle();
              },
            ),
            const Spacer(),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {
                circleController.exportCircle();
              },
            ),
          ],
        );
}

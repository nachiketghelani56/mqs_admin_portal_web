import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget userDataTopButtonsWidget({
  required UserDataController userDataController,
  required MqsDashboardController mqsDashboardController,
  required BuildContext context,
}) {
  return context.width > SizeConfig.size1885
      ? Row(
          children: [
            CustomPrefixButton(
              prefixIcon: ImageConfig.filter,
              btnText: StringConfig.dashboard.filter,
              padding: SizeConfig.size15,
              onTap: () {
                mqsDashboardController.scaffoldKey.currentState
                    ?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            if (userDataController.users.isNotEmpty)
              SearchTextField(
                controller: userDataController.searchController,
                hintText: StringConfig.dashboard.searchByNameEmail,
                onChanged: (p0) {
                  userDataController.searchUser();
                },
              ),
            const Spacer(),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                // userDataController.importUserIAM();
              },
            ),
            SizeConfig.size12.width,
            if (userDataController.users.isNotEmpty)
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  userDataController.searchController.clear();
                  userDataController.exportUserIAM();
                },
              ),
            SizeConfig.size12.width,
            CustomPrefixButton(
              prefixIcon: ImageConfig.add,
              padding: SizeConfig.size15,
              btnText: StringConfig.database.addUser,
              onTap: () {
                userDataController.isEdit.value = false;
                userDataController.isAdd.value = true;
                userDataController.clearAllFields();
                mqsDashboardController.userStatus.value = "add_user";
              },
            ),
          ],
        )
      : Row(
          children: [
            CustomIconButton(
              icon: ImageConfig.filter,
              onTap: () {
                mqsDashboardController.scaffoldKey.currentState
                    ?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            if (userDataController.users.isNotEmpty)
              SearchTextField(
                controller: userDataController.searchController,
                hintText: StringConfig.dashboard.searchByNameEmail,
                onChanged: (p0) {
                  userDataController.searchUser();
                },
              ),
            const Spacer(),
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                // userDataController.importUserIAM();
              },
            ),
            SizeConfig.size12.width,
            if (userDataController.users.isNotEmpty)
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  userDataController.searchController.clear();
                  userDataController.exportUserIAM();
                },
              ),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.add,
              onTap: () {
                userDataController.isEdit.value = false;
                userDataController.isAdd.value = true;
                userDataController.clearAllFields();
                mqsDashboardController.userStatus.value = "add_user";
              },
            ),
          ],
        );
}

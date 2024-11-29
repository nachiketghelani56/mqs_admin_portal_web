import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/profile_menu_widget.dart';

Widget homeHeaderWidget(
    {required HomeController homeController,
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey}) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size40, vertical: SizeConfig.size15),
    color: ColorConfig.whiteColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (context.width < SizeConfig.size900) ...[
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: ColorConfig.primaryColor,
                ),
              ),
              SizeConfig.size10.width,
            ],
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizeConfig.size16.width,
                  Image.asset(
                    ImageConfig.notification,
                    height: SizeConfig.size44,
                    width: SizeConfig.size44,
                  ),
                  SizeConfig.size16.width,
                  Image.asset(
                    ImageConfig.myProfile,
                    height: SizeConfig.size44,
                    width: SizeConfig.size44,
                  ).tap(
                    () {
                      profileMenuWidget(
                          context: context, homeController: homeController);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}

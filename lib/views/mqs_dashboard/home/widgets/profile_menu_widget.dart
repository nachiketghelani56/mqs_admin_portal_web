import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/widgets/logout_dialog_widget.dart';

profileMenuWidget(
    {required BuildContext context, required HomeController homeController}) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(SizeConfig.size100, SizeConfig.size70,
        SizeConfig.size40, SizeConfig.size100),
    items: [
      for (int i = 0; i < homeController.profileOpts.length; i++)
        PopupMenuItem<int>(
          onTap: () {
            if (i == 2) {
              logoutDialogWidget();
            }
          },
          child: Row(
            children: [
              Image.asset(
                homeController.profileOpts[i].icon,
                height: SizeConfig.size24,
                width: SizeConfig.size24,
                color: ColorConfig.primaryColor,
              ),
              SizeConfig.size8.width,
              Text(
                homeController.profileOpts[i].title,
                style: FontTextStyleConfig.fieldTextStyle,
              ),
            ],
          ),
        ),
    ],
  );
}

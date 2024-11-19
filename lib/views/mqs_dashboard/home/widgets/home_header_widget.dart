import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';

Widget homeHeaderWidget(
    {required HomeController homeController, required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size40, vertical: SizeConfig.size15),
    color: ColorConfig.whiteColor,
    child: Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConfig.home.wellAbove,
                style: FontTextStyleConfig.homeTitleTextStyle,
              ),
              Text(
                StringConfig.home.tm,
                style: FontTextStyleConfig.homeTitleUpTextStyle,
              ),
            ],
          ),
        ),
        SizeConfig.size10.width,
        Container(
          width: SizeConfig.size319,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: ColorConfig.primaryColor),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                ImageConfig.searchNew,
                height: SizeConfig.size18,
                width: SizeConfig.size18,
              ),
              SizeConfig.size8.width,
              Expanded(
                child: TextFormField(
                  controller: homeController.searchController,
                  style: FontTextStyleConfig.searchTextStyle,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: StringConfig.home.search,
                    hintStyle: FontTextStyleConfig.searchTextStyle,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: SizeConfig.size10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizeConfig.size40.width,
        Image.asset(
          ImageConfig.help,
          height: SizeConfig.size44,
          width: SizeConfig.size44,
        ),
        SizeConfig.size16.width,
        Image.asset(
          ImageConfig.notification,
          height: SizeConfig.size44,
          width: SizeConfig.size44,
        ),
      ],
    ),
  );
}

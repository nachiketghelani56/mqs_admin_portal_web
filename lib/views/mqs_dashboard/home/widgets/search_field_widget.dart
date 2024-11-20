import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';

Widget searchFieldWidget({required HomeController homeController}) {
  return Container(
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
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

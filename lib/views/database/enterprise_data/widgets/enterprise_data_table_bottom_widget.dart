import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';

Widget enterpriseDataTableBottomWidget(
    {required EnterpriseDataController enterpriseDataController}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.tableBottomDecoration.copyWith(
      border:  Border(
        bottom: BorderSide.none,
        top: BorderSide(color:ColorConfig.labelColor.withOpacity(SizeConfig.size0point4)),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Text(
          '${StringConfig.dashboard.rowsPerPage} ${enterpriseDataController.pageLimit}',
          style: FontTextStyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size5.width,
        const Spacer(),
        Text(
          '${enterpriseDataController.offset.value + 1}-${enterpriseDataController.getMaxOffset()} ${StringConfig.dashboard.of} ${enterpriseDataController.searchedEnterprises.length}',
          style: FontTextStyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size20.width,
        IconButton(
          onPressed: () {
            enterpriseDataController.prevPage();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.size15,
            color: ColorConfig.textFieldTextColor,
          ),
        ),
        IconButton(
          onPressed: () {
            enterpriseDataController.nextPage();
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.size15,
            color: ColorConfig.textFieldTextColor,
          ),
        ),
      ],
    ),
  );
}

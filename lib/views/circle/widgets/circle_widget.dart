import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/add_circle_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_top_buttons_widget.dart';

Widget circleWidget(
    {required BuildContext context,
    required CircleController circleController,
    required GlobalKey<ScaffoldState> scaffoldKey}) {
  return Obx(
    () => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: SizeConfig.size25),
            child: Container(
              decoration: FontTextStyleConfig.cardDecoration,
              padding: const EdgeInsets.all(SizeConfig.size16),
              child: Column(
                children: [
                  circleTopButtonsWidget(
                    circleController: circleController,
                    scaffoldKey: scaffoldKey,
                    context: context,
                  ),
                  SizeConfig.size26.height,
                  circleController.searchedCircle.isEmpty
                      ? Text(
                          StringConfig.dashboard.noDataFound,
                          style: FontTextStyleConfig.subtitleStyle,
                        ).center
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              circleTableTitleWidget(),
                              for (int i = circleController.offset.value;
                                  i < circleController.getMaxOffset();
                                  i++)
                                circleTableRowWidget(
                                  circleController: circleController,
                                  isSelected:
                                      circleController.viewIndex.value == i,
                                  context: context,
                                  index: i,
                                ),
                              circleTableBottomWidget(
                                  circleController: circleController),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        if (context.width > SizeConfig.size1500 &&
            circleController.searchedCircle.isNotEmpty) ...[
          SizeConfig.size20.width,
          Expanded(
            child: circleController.isAdd.value || circleController.isEdit.value
                ? addCircleWidget(
                    circleController: circleController, context: context)
                : circleController.viewIndex.value >= 0
                    ? circleDetailWidget(circleController: circleController)
                    : const SizedBox.shrink(),
          ),
        ],
      ],
    ).paddingOnly(
      left: SizeConfig.size40,
      right: SizeConfig.size40,
      top: SizeConfig.size25,
    ),
  );
}

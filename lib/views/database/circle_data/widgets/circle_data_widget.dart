import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/widgets/circle_data_top_buttons_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget circleDataWidget({
  required BuildContext context,
  required CircleDataController circleDataController,required MqsDashboardController mqsDashboardController,
  required GlobalKey<ScaffoldState> scaffoldKey,
 
}) {
  return Obx(
    () => circleDataController.circleLoader.value
        ? const LoaderWidget()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                  child: Container(
                    decoration: circleDataController.circle.isNotEmpty
                        ? FontTextStyleConfig.cardDecoration
                        : null,
                    padding: const EdgeInsets.all(SizeConfig.size16),
                    child: Column(
                      children: [

                        circleDataTopButtonsWidget(
                          circleDataController: circleDataController,
                          scaffoldKey: scaffoldKey,
                          context: context,
                            mqsDashboardController:mqsDashboardController,
                        ),
                        SizeConfig.size26.height,
                        circleDataController.searchedCircle.isEmpty
                            ? Text(
                                StringConfig.dashboard.noDataFound,
                                style: FontTextStyleConfig.subtitleStyle,
                              ).center
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    circleDataTableTitleWidget(context: context),
                                    for (int i = circleDataController.offset.value;
                                        i < circleDataController.getMaxOffset();
                                        i++)
                                      circleDataTableRowWidget(
                                        circleDataController: circleDataController,
                                        isSelected:
                                            circleDataController.viewIndex.value ==
                                                i,
                                        context: context,
                                        index: i,

                                      ),
                                    circleDataTableBottomWidget(
                                        circleDataController: circleDataController),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              // if (context.width > SizeConfig.size1500 &&
              //     circleDataController.searchedCircle.isNotEmpty) ...[
              //   SizeConfig.size20.width,
              //   Expanded(
              //     child: circleDataController.isAdd.value ||
              //             circleDataController.isEdit.value
              //         ? addCircleWidget(
              //             circleDataController: circleDataController, context: context)
              //         : circleDataController.viewIndex.value >= 0
              //             ? circleDetailWidget(
              //                 circleDataController: circleDataController)
              //             : const SizedBox.shrink(),
              //   ),
              // ],
            ],
          ).paddingOnly(
            left: SizeConfig.size40,
            right: SizeConfig.size40,
            top: SizeConfig.size25,
          ),
  );
}

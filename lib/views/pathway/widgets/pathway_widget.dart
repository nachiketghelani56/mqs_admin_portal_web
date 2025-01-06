import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/add_pathway_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_top_buttons_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget pathwayWidget(
    {required BuildContext context,
    required PathwayController pathwayController,
    required GlobalKey<ScaffoldState> scaffoldKey,
    bool isStorage = false}) {
  return Obx(
    () => pathwayController.pathwayLoader.value
        ? const LoaderWidget()
        : Row(
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
                        if (!isStorage) ...[
                          pathwayTopButtonsWidget(
                            pathwayController: pathwayController,
                            scaffoldKey: scaffoldKey,
                            context: context,
                          ),
                          SizeConfig.size26.height,
                        ],
                        pathwayController.searchedPathway.isEmpty
                            ? Text(
                                StringConfig.dashboard.noDataFound,
                                style: FontTextStyleConfig.subtitleStyle,
                              ).center
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    pathwayTableTitleWidget(),
                                    for (int i = pathwayController.offset.value;
                                        i < pathwayController.getMaxOffset();
                                        i++)
                                      pathwayTableRowWidget(
                                        pathwayController: pathwayController,
                                        isSelected:
                                            pathwayController.viewIndex.value ==
                                                i,
                                        context: context,
                                        index: i,
                                      ),
                                    pathwayTableBottomWidget(
                                        pathwayController: pathwayController),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              if (context.width > SizeConfig.size1500 &&
                  pathwayController.searchedPathway.isNotEmpty) ...[
                SizeConfig.size20.width,
                Expanded(
                  child: pathwayController.isAdd.value ||
                          pathwayController.isEdit.value
                      ? addPathwayWidget(
                          pathwayController: pathwayController,
                          context: context)
                      : pathwayController.viewIndex.value >= 0
                          ? pathwayDetailWidget(
                              pathwayController: pathwayController)
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

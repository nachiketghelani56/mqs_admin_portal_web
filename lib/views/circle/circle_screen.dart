import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_top_buttons_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class CircleScreen extends StatelessWidget {
  CircleScreen({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeController _homeController = Get.find();
  final CircleController _circleController = Get.put(CircleController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHeaderWidget(
            homeController: _homeController,
            context: context,
            scaffoldKey: scaffoldKey),
        SizeConfig.size15.height,
        Expanded(
          child: Obx(
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
                            circleController: _circleController,
                            scaffoldKey: scaffoldKey,
                            context: context,
                          ),
                          SizeConfig.size26.height,
                          _circleController.searchedCircle.isEmpty
                              ? Text(
                                  StringConfig.dashboard.noDataFound,
                                  style: FontTextStyleConfig.subtitleStyle,
                                ).center
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      circleTableTitleWidget(),
                                      for (int i =
                                              _circleController.offset.value;
                                          i < _circleController.getMaxOffset();
                                          i++)
                                        circleTableRowWidget(
                                          circleController: _circleController,
                                          isSelected: _circleController
                                                  .viewIndex.value ==
                                              i,
                                          context: context,
                                          index: i,
                                        ),
                                      circleTableBottomWidget(
                                          circleController: _circleController),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (context.width > SizeConfig.size1500 &&
                    _circleController.searchedCircle.isNotEmpty) ...[
                  SizeConfig.size20.width,
                  Expanded(
                    child: _circleController.viewIndex.value >= 0
                        ? circleDetailWidget(
                            circleController: _circleController)
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ).paddingOnly(
              left: SizeConfig.size40,
              right: SizeConfig.size40,
              top: SizeConfig.size25,
            ),
          ),
        ),
      ],
    );
  }
}

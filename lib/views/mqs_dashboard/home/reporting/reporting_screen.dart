import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/circle_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/well_above_charts_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/auth_summary_widget.dart';

class ReportingScreen extends StatelessWidget {
  ReportingScreen({super.key, required this.scaffoldKey});

  final ReportingController _reportingController =
      Get.put(ReportingController());
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size40, vertical: SizeConfig.size15),
            color: ColorConfig.whiteColor,
            child: Row(
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
                  child: Text(
                    StringConfig.reporting.lastUpdate,
                    style: FontTextStyleConfig.dateTextStyle,
                  ),
                ),
                SizeConfig.size10.width,
                Image.asset(
                  ImageConfig.notification,
                  height: SizeConfig.size44,
                  width: SizeConfig.size44,
                ),
              ],
            ),
          ),
          SizeConfig.size40.height,
          Column(
            children: [
              headerWidget(
                  reportingController: _reportingController, context: context),
              SizeConfig.size34.height,
              authSummaryWidget(
                  context: context, reportingController: _reportingController),
              SizeConfig.size34.height,
              circleSummaryWidget(
                  context: context, reportingController: _reportingController),
              SizeConfig.size34.height,
              wellAboveChartsWidget(
                  reportingController: _reportingController, context: context),
              SizeConfig.size50.height,
            ],
          ).paddingSymmetric(horizontal: SizeConfig.size40),
        ],
      ),
    );
  }
}

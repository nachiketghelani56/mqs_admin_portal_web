import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/well_above_charts_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/well_above_score_widget.dart';

class ReportingScreen extends StatelessWidget {
  ReportingScreen({super.key});

  final ReportingController _reportingController =
      Get.put(ReportingController());

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
              headerWidget(reportingController: _reportingController),
              SizeConfig.size34.height,
              wellAboveScoreWidget(),
              SizeConfig.size39.height,
              wellAboveChartsWidget(reportingController: _reportingController),
              SizeConfig.size50.height,
            ],
          ).paddingSymmetric(horizontal: SizeConfig.size40),
        ],
      ),
    );
  }
}

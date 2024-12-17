import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/well_above_indictaors_widget.dart';

Widget wellAboveChartsWidget(
    {required ReportingController reportingController,
    required BuildContext context}) {
  return context.width > SizeConfig.size1500
      ? Row(
          children: [
            Expanded(
              flex: SizeConfig.size5.toInt(),
              child: wellAboveIndicatorsWidget(
                  reportingController: reportingController, context: context),
            ),
            // SizeConfig.size34.width,
            // Expanded(
            //   flex: SizeConfig.size4.toInt(),
            //   child: const SizedBox.shrink(),
            // ),
          ],
        )
      : Column(
          children: [
            // obSummaryWidget(
            //     reportingController: reportingController, context: context),
            // SizeConfig.size34.height,
            wellAboveIndicatorsWidget(
                reportingController: reportingController, context: context),
          ],
        );
}

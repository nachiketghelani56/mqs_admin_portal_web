import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/ob_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/auth_summary_widget.dart';

Widget authAndOBSummaryWidget(
    {required BuildContext context,
    required ReportingController reportingController}) {
  return context.width > SizeConfig.size1800
      ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: authSummaryWidget(
                  context: context, reportingController: reportingController),
            ),
            SizeConfig.size34.width,
            Expanded(
              flex: SizeConfig.size5.toInt(),
              child: obSummaryWidget(
                  reportingController: reportingController, context: context),
            ),
          ],
        )
      : Column(
          children: [
            authSummaryWidget(
                context: context, reportingController: reportingController),
            SizeConfig.size34.height,
            obSummaryWidget(
                reportingController: reportingController, context: context),
          ],
        );
}

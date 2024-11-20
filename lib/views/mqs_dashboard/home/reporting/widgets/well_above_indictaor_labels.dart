import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';

List<Widget> wellAboveIndicatorLabels(
    {required ReportingController reportingController}) {
  return reportingController.barChartOpts
      .map((key, value) => MapEntry(
            key,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: SizeConfig.size16,
                  width: SizeConfig.size16,
                  color: value,
                ),
                SizeConfig.size6.width,
                Text(
                  key,
                  style: FontTextStyleConfig.dateTextStyle
                      .copyWith(color: ColorConfig.cardTitleColor),
                )
              ],
            ),
          ))
      .values
      .toList();
}

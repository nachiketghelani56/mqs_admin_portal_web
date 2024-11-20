import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';

Widget tabWidget({required ReportingController reportingController}) {
  return Row(
    children: [
      Container(
        height: SizeConfig.size58,
        decoration: FontTextStyleConfig.cardDecoration,
        child: Obx(
          () => Row(
            children: [
              for (int i = 0; i < reportingController.options.length; i++)
                Container(
                  width: SizeConfig.size120,
                  decoration: BoxDecoration(
                    color: i == reportingController.optionIndex.value
                        ? ColorConfig.primaryColor
                        : null,
                    borderRadius: BorderRadius.horizontal(
                      left: i == 0
                          ? const Radius.circular(SizeConfig.size12)
                          : Radius.zero,
                      right: i == reportingController.options.length - 1
                          ? const Radius.circular(SizeConfig.size12)
                          : Radius.zero,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    reportingController.options[i],
                    style: FontTextStyleConfig.fieldTextStyle.copyWith(
                        color: i == reportingController.optionIndex.value
                            ? ColorConfig.whiteColor
                            : null),
                  ),
                ).tap(() {
                  reportingController.optionIndex.value = i;
                }),
            ],
          ),
        ),
      ),
    ],
  );
}

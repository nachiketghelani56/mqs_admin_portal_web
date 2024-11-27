import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

customRangeDialog(
    {required BuildContext context,
    required ReportingController reportingController,
    required String type}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: SizeConfig.size444,
            padding: const EdgeInsets.all(SizeConfig.size22),
            child: Form(
              key: reportingController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    StringConfig.reporting.customRange,
                    style: FontTextStyleConfig.tableTextStyle,
                  ),
                  SizeConfig.size25.height,
                  CustomTextField(
                    controller: reportingController.startDateController,
                    label: StringConfig.reporting.startDate,
                    suffixIcon: ImageConfig.calendar,
                    readOnly: true,
                    validator: (p0) => Validator.emptyValidator(
                        p0 ?? "", StringConfig.reporting.startDate),
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(0),
                        lastDate: DateTime(3000),
                        initialDate: DateTime.now(),
                      );
                      if (date != null) {
                        reportingController.startDateController.text =
                            DateFormat('dd/MM/yyyy').format(date);
                      }
                    },
                  ),
                  SizeConfig.size10.height,
                  CustomTextField(
                    controller: reportingController.endDateController,
                    label: StringConfig.reporting.endDate,
                    suffixIcon: ImageConfig.calendar,
                    readOnly: true,
                    validator: (p0) => Validator.emptyValidator(
                        p0 ?? "", StringConfig.reporting.endDate),
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(0),
                        lastDate: DateTime(3000),
                        initialDate: DateTime.now(),
                      );
                      if (date != null) {
                        reportingController.endDateController.text =
                            DateFormat('dd/MM/yyyy').format(date);
                      }
                    },
                  ),
                  SizeConfig.size25.height,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          isSelected: false,
                          btnText: StringConfig.dashboard.cancel,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizeConfig.size12.width,
                      Expanded(
                        child: CustomButton(
                          btnText: StringConfig.dashboard.apply,
                          onTap: () {
                            if (reportingController.formKey.currentState
                                    ?.validate() ??
                                false) {
                              Get.back();
                              if (type == StringConfig.reporting.authSummary) {
                                reportingController.authFilter.value =
                                    '${reportingController.startDateController.text} - ${reportingController.endDateController.text}';
                                reportingController.filterAuth();
                              } else if (type ==
                                  StringConfig.reporting.circleSummary) {
                                reportingController.circleFilter.value =
                                    '${reportingController.startDateController.text} - ${reportingController.endDateController.text}';
                                reportingController.filterCircle();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

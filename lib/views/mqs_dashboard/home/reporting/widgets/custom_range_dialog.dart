import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  controller: type == StringConfig.reporting.circleSummary
                      ? reportingController.startCircleDateController
                      : type == StringConfig.reporting.circleTypeSummary
                          ? reportingController.startCircleTypeDateController
                          : type ==
                                  StringConfig.reporting.subscriptionTypeSummary
                              ? reportingController
                                  .startSubscriptionTypeDateController
                              : reportingController.startDateController,
                  label: StringConfig.reporting.startDate,
                  suffixIcon: ImageConfig.calendar,
                  readOnly: true,
                  validator: (p0) => Validator.emptyValidator(
                      p0 ?? "", StringConfig.reporting.startDate),
                  onTap: () async {
                    if (type == StringConfig.reporting.circleSummary) {
                      reportingController.startCircleDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.circleTypeSummary) {
                      reportingController.startCircleTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.subscriptionTypeSummary) {
                      reportingController
                              .startSubscriptionTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else {
                      reportingController.startDateController.text =
                          await reportingController.pickDate(context: context);
                    }
                  },
                  onSuffixIconTap: () async {
                    if (type == StringConfig.reporting.circleSummary) {
                      reportingController.startCircleDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.circleTypeSummary) {
                      reportingController.startCircleTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.subscriptionTypeSummary) {
                      reportingController
                              .startSubscriptionTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else {
                      reportingController.startDateController.text =
                          await reportingController.pickDate(context: context);
                    }
                  },
                ),
                SizeConfig.size10.height,
                CustomTextField(
                  controller: type == StringConfig.reporting.circleSummary
                      ? reportingController.endCircleDateController
                      : type == StringConfig.reporting.circleTypeSummary
                          ? reportingController.endCircleTypeDateController
                          : type ==
                                  StringConfig.reporting.subscriptionTypeSummary
                              ? reportingController
                                  .endSubscriptionTypeDateController
                              : reportingController.endDateController,
                  label: StringConfig.reporting.endDate,
                  suffixIcon: ImageConfig.calendar,
                  readOnly: true,
                  validator: (p0) => Validator.emptyValidator(
                      p0 ?? "", StringConfig.reporting.endDate),
                  onTap: () async {
                    if (type == StringConfig.reporting.circleSummary) {
                      reportingController.endCircleDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.circleTypeSummary) {
                      reportingController.endCircleTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.subscriptionTypeSummary) {
                      reportingController
                              .endSubscriptionTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else {
                      reportingController.endDateController.text =
                          await reportingController.pickDate(context: context);
                    }
                  },
                  onSuffixIconTap: () async {
                    if (type == StringConfig.reporting.circleSummary) {
                      reportingController.endCircleDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.circleTypeSummary) {
                      reportingController.endCircleTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else if (type ==
                        StringConfig.reporting.subscriptionTypeSummary) {
                      reportingController
                              .endSubscriptionTypeDateController.text =
                          await reportingController.pickDate(context: context);
                    } else {
                      reportingController.endDateController.text =
                          await reportingController.pickDate(context: context);
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
                                  '${reportingController.startCircleDateController.text} - ${reportingController.endCircleDateController.text}';
                              reportingController.filterCircle();
                            } else if (type ==
                                StringConfig.reporting.circleTypeSummary) {
                              reportingController.circleFilterType.value =
                                  '${reportingController.startCircleTypeDateController.text} - ${reportingController.endCircleTypeDateController.text}';
                              reportingController.filterCircleType();
                            } else if (type ==
                                StringConfig.reporting.subscriptionSummary) {
                              reportingController.subscriptionFilter.value =
                                  '${reportingController.startDateController.text} - ${reportingController.endDateController.text}';
                              reportingController.filterSubscription();
                            } else if (type ==
                                StringConfig
                                    .reporting.subscriptionTypeSummary) {
                              reportingController.subscriptionFilterType.value =
                                  '${reportingController.startSubscriptionTypeDateController.text} - ${reportingController.endSubscriptionTypeDateController.text}';
                              reportingController.filterSubscriptionType();
                            } else if (type ==
                                StringConfig.reporting.onboardingSummary) {
                              reportingController.obFilter.value =
                                  '${reportingController.startDateController.text} - ${reportingController.endDateController.text}';
                              reportingController.filterOnboarding();
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
    },
  );
}

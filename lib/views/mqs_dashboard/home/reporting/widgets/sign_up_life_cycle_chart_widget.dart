import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/models/line_chart_model.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget signUpLifeCycleChartWidget(
    {required ReportingController reportingController,
    required BuildContext context}) {
  return Container(
    height: SizeConfig.size498,
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                StringConfig.reporting.signUpLifeCycle,
                style: FontTextStyleConfig.cardTitleTextStyle,
              ),
            ),
            PopupMenuButton(
              icon: Container(
                height: SizeConfig.size46,
                decoration: FontTextStyleConfig.topOptionDecoration.copyWith(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
                child: Image.asset(
                  ImageConfig.filterNew,
                  width: SizeConfig.size22,
                ),
              ),
              onSelected: (value) {
                reportingController.signUpChartFilter.value = value;
                if (value == StringConfig.reporting.year) {
                  reportingController.getYearWiseSignUpChart();
                } else if (value == StringConfig.reporting.month) {
                  reportingController.getMonthWiseSignUpChart();
                } else if (value == StringConfig.reporting.week) {
                  reportingController.getWeekWiseSignUpChart();
                } else {
                  reportingController.getDayWiseSignUpChart();
                }
              },
              itemBuilder: (context) {
                return [
                  for (int i = 0; i < reportingController.chartOpts.length; i++)
                    PopupMenuItem(
                      value: reportingController.chartOpts[i],
                      child: Text(
                        reportingController.chartOpts[i],
                        style: FontTextStyleConfig.fieldTextStyle,
                      ),
                    ),
                ];
              },
            ),
          ],
        ),
        SizeConfig.size20.height,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: DateTimeCategoryAxis(
                    majorTickLines:
                        const MajorTickLines(width: SizeConfig.size0),
                    labelStyle: FontTextStyleConfig.subMenuTextStyle
                        .copyWith(color: ColorConfig.cardTitleColor),
                    axisLine: AxisLine(
                      color: ColorConfig.cardTitleColor
                          .withOpacity(SizeConfig.size0point1),
                    ),
                    dateFormat: reportingController.signUpChartFilter.value ==
                            StringConfig.reporting.year
                        ? DateFormat('yyyy')
                        : reportingController.signUpChartFilter.value ==
                                StringConfig.reporting.month
                            ? DateFormat('MMM yyyy')
                            : reportingController.signUpChartFilter.value ==
                                    StringConfig.reporting.day
                                ? DateFormat('d/M/y')
                                : DateFormat('d MMM'),
                    labelIntersectAction: AxisLabelIntersectAction.rotate45,
                  ),
                  primaryYAxis: NumericAxis(
                    majorTickLines:
                        const MajorTickLines(width: SizeConfig.size0),
                    labelStyle: FontTextStyleConfig.subMenuTextStyle
                        .copyWith(color: ColorConfig.cardTitleColor),
                    axisLine: AxisLine(
                      color: ColorConfig.cardTitleColor
                          .withOpacity(SizeConfig.size0point1),
                    ),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <LineSeries<LineChartModel, DateTime>>[
                    for (var type
                        in reportingController.singUpChartOpts.entries.toList())
                      if (type.key != StringConfig.reporting.cancelled)
                        LineSeries<LineChartModel, DateTime>(
                          name: type.key,
                          dataSource: reportingController.signUpChartData,
                          xValueMapper: (LineChartModel data, _) => data.x,
                          yValueMapper: (LineChartModel data, _) {
                            if (type.key ==
                                StringConfig.reporting.onboradingCompleted) {
                              return data.y2;
                            } else if (type.key ==
                                StringConfig.reporting.subscribed) {
                              return data.y3;
                            } else if (type.key ==
                                StringConfig.reporting.subscriptionExpired) {
                              return data.y4;
                            } else if (type.key ==
                                StringConfig.reporting.cancelled) {
                              return data.y5;
                            }
                            else if (type.key ==
                                StringConfig.reporting.notSubscribed) {
                              return data.y6;
                            }
                            return data.y1;
                          },
                          color: type.value,
                        ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reportingController.singUpChartOpts
                    .map(
                      (key, value) => MapEntry(
                        key,
                        TextButton.icon(
                          icon: Container(
                            height: SizeConfig.size10,
                            width: SizeConfig.size10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: value,
                            ),
                          ),
                          onPressed: () {
                            if (key == StringConfig.reporting.cancelled) {
                              errorDialogWidget(
                                  msg: StringConfig
                                      .reporting.pendingSubscription);
                            } else {
                              reportingController.filterSignUp();
                              reportingController.reportType.value = key;
                            }
                          },
                          label: Text(
                            key,
                            style: FontTextStyleConfig.dateTextStyle
                                .copyWith(color: ColorConfig.cardTitleColor),
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList()
                    .separator(SizeConfig.size12.height)
                    .toList(),
              ),
              SizeConfig.size30.width,
            ],
          ),
        ),
      ],
    ),
  );
}

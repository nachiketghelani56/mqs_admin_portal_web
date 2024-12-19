import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget signUpLifeCycleChartWidget(
    {required ReportingController reportingController}) {
  return Container(
    height: SizeConfig.size498,
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConfig.reporting.signUpLifeCycle,
          style: FontTextStyleConfig.cardTitleTextStyle,
        ),
        SizeConfig.size20.height,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    majorTickLines:
                        const MajorTickLines(width: SizeConfig.size0),
                    labelStyle: FontTextStyleConfig.subMenuTextStyle
                        .copyWith(color: ColorConfig.cardTitleColor),
                    axisLine: AxisLine(
                      color: ColorConfig.cardTitleColor
                          .withOpacity(SizeConfig.size0point1),
                    ),
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
                  series: <LineSeries<ChartModel, String>>[
                    for (var type
                        in reportingController.singUpChartOpts.entries.toList())
                      LineSeries<ChartModel, String>(
                        name: type.key,
                        dataSource:
                            reportingController.signUpLifeCycleChartData,
                        xValueMapper: (ChartModel data, _) => data.x,
                        yValueMapper: (ChartModel data, _) {
                          if (type.key ==
                              StringConfig.reporting.onboradingCompleted) {
                            return data.y2;
                          } else if (type.key ==
                              StringConfig.reporting.subscribed) {
                            return data.y3;
                          } else if (type.key ==
                              StringConfig.reporting.cancelled) {
                            return data.y4;
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: SizeConfig.size10,
                              width: SizeConfig.size10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value,
                              ),
                            ),
                            SizeConfig.size22.width,
                            Text(
                              key,
                              style: FontTextStyleConfig.dateTextStyle
                                  .copyWith(color: ColorConfig.cardTitleColor),
                            )
                          ],
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

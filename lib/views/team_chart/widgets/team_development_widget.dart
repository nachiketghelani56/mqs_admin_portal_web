import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';
import 'package:mqs_admin_portal_web/views/team_chart/controller/team_chart_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget teamDevelopmentWidget(
    {required TeamChartController teamChartController}) {
  return Container(
    decoration: FontTextStyleConfig.cardDecoration,
    padding: const EdgeInsets.all(SizeConfig.size22),
    height: SizeConfig.size462,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConfig.teamChart.teamDevelopment,
          style: FontTextStyleConfig.chartTitleTextStyle,
        ),
        20.height,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 600,
                  child: SfCartesianChart(
                    series: <CartesianSeries<ChartModel, String>>[
                      ColumnSeries(
                        dataSource: teamChartController.devCharData,
                        xValueMapper: (ChartModel data, _) => data.x,
                        yValueMapper: (ChartModel data, _) => data.y1,
                        width: SizeConfig.size0point3,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6)),
                        color: ColorConfig.bullet1Color,
                      ),
                    ],
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
                      majorGridLines: MajorGridLines(
                        color: ColorConfig.cardTitleColor
                            .withOpacity(SizeConfig.size0point1),
                      ),
                      labelStyle: FontTextStyleConfig.subMenuTextStyle
                          .copyWith(color: ColorConfig.cardTitleColor),
                      axisLine: AxisLine(
                        color: ColorConfig.cardTitleColor
                            .withOpacity(SizeConfig.size0point1),
                      ),
                      interval: SizeConfig.size1,
                    ),
                  ),
                ).center,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: teamChartController.teamDevOpts
                    .map(
                      (key, value) => MapEntry(
                        key,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: SizeConfig.size16,
                              width: SizeConfig.size16,
                              color: value,
                            ),
                            SizeConfig.size22.width,
                            Text(
                              key,
                              style: FontTextStyleConfig.chartDescTextStyle
                                  .copyWith(
                                      color: ColorConfig.cardTitleColor,
                                      fontWeight: FontWeight.w300),
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

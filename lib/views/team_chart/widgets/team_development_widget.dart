import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/models/common_chart_model.dart';
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
        SizeConfig.size20.height,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: SizeConfig.size600,
                  child: SfCartesianChart(
                    series: <CartesianSeries>[
                      for (String type in teamChartController.allTypes)
                        ColumnSeries<ChartData, String>(
                          dataSource: teamChartController.chartData
                              .where((data) => data.type == type)
                              .toList(),
                          xValueMapper: (ChartData data, _) => data.month,
                          yValueMapper: (ChartData data, _) => data.count,
                          name: type,
                          width: SizeConfig.size0point8,
                          spacing: SizeConfig.size0point1,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(SizeConfig.size6)),
                          color: teamChartController.typeColors[type],
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

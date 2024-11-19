import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget wellAboveIndicatorsWidget(
    {required ReportingController reportingController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        StringConfig.reporting.wellAboveIndicators,
        style: FontTextStyleConfig.cardTitleTextStyle,
      ),
      SizeConfig.size26.height,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: reportingController.barChartOpts
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
            .toList(),
      ).paddingSymmetric(horizontal: SizeConfig.size30),
      20.height,
      Expanded(
        child: SfCartesianChart(
          series: <CartesianSeries<ChartModel, String>>[
            ColumnSeries(
              dataSource: reportingController.indicatorCharData,
              xValueMapper: (ChartModel data, _) => data.x,
              yValueMapper: (ChartModel data, _) => data.y1,
              width: SizeConfig.size0point3,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(6)),
              color: ColorConfig.bullet1Color,
            ),
          ],
          primaryXAxis: CategoryAxis(
            majorTickLines: const MajorTickLines(width: SizeConfig.size0),
            labelStyle: FontTextStyleConfig.subMenuTextStyle
                .copyWith(color: ColorConfig.cardTitleColor),
            axisLine: AxisLine(
              color: ColorConfig.cardTitleColor
                  .withOpacity(SizeConfig.size0point1),
            ),
          ),
          primaryYAxis: NumericAxis(
            majorTickLines: const MajorTickLines(width: SizeConfig.size0),
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
      ),
    ],
  );
}

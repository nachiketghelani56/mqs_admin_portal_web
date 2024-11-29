import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget wellAboveIndicatorsWidget(
    {required ReportingController reportingController,
    required BuildContext context}) {
  return Container(
    height: SizeConfig.size498,
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   StringConfig.reporting.wellAboveIndicators,
        //   style: FontTextStyleConfig.cardTitleTextStyle,
        // ),
        // SizeConfig.size26.height,
        // context.width > SizeConfig.size600
        //     ? Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: wellAboveIndicatorLabels(
        //             reportingController: reportingController),
        //       ).paddingSymmetric(horizontal: SizeConfig.size30)
        //     : Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: wellAboveIndicatorLabels(
        //             reportingController: reportingController),
        //       ),
        SizeConfig.size20.height,
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
    ),
  );
}

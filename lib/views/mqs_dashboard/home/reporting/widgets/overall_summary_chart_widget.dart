import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/models/reporting_chart_model.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget overallSummaryChartWidget(
    {required ReportingController reportingController,
    required BuildContext context}) {
  reportingController.getOverAllData();
  return Container(
    height: SizeConfig.size498,
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConfig.reporting.userOverview,
          style: FontTextStyleConfig.cardTitleTextStyle,
        ),
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
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder<List<ReportingChartModel>>(
                  future: reportingController.getOverAllData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              "${StringConfig.reporting.error} ${snapshot.error}"));
                    } else if (!snapshot.hasData ||
                        (snapshot.data?.isEmpty ?? false)) {
                      return Center(
                          child: Text(StringConfig.reporting.noDataAvailable));
                    }
                    final List<ReportingChartModel>? metrics = snapshot.data;
                    return SfCartesianChart(
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
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                      ),
                      series: [
                        ColumnSeries<ReportingChartModel, String>(
                          dataSource: metrics,
                          xValueMapper: (ReportingChartModel data, _) =>
                              data.label,
                          yValueMapper: (ReportingChartModel data, _) =>
                              data.value,
                          name: '',
                          width: SizeConfig.size0point3,
                          pointColorMapper: (ReportingChartModel data, _) {
                            switch (data.label) {
                              case 'Users':
                                return ColorConfig.bullet6Color;
                              case 'Enterprise':
                                return ColorConfig.secondaryColor;
                              case 'Circles':
                                return ColorConfig.dividerColor;
                              case 'User Subscription':
                                return ColorConfig.card1TextColor;
                              default:
                                return Colors.grey;
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reportingController.totalReport
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
                            reportingController.overAllSummary();
                            reportingController.reportType.value = key;
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

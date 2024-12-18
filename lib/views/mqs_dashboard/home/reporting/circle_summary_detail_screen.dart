import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/custom_range_dialog.dart';

class CircleSummaryDetailScreen extends StatelessWidget {
  CircleSummaryDetailScreen({
    super.key,
  });

  final CircleController _circleController = Get.put(CircleController());
  final ReportingController _reportingController =
      Get.put(ReportingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _reportingController.circleKey,
      body: SingleChildScrollView(
        padding: context.width > SizeConfig.size600
            ? const EdgeInsets.only(
                left: SizeConfig.size10,
                right: SizeConfig.size10,
                top: SizeConfig.size25,
              )
            : const EdgeInsets.all(SizeConfig.size0),
        child: Obx(
          () => circleWidget(
            context: context,
            circleController: _circleController,
            reportingController: _reportingController,
            scaffoldKey: _reportingController.circleKey,
            filterWidget: Row(
              children: [
                PopupMenuButton(
                  icon: Container(
                    height: SizeConfig.size46,
                    decoration:
                        FontTextStyleConfig.topOptionDecoration.copyWith(
                      borderRadius: BorderRadius.circular(SizeConfig.size12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size15),
                    child: Image.asset(
                      ImageConfig.filterNew,
                      width: SizeConfig.size22,
                    ),
                  ),
                  onOpened: () {
                    _circleController.searchController.clear();
                  },
                  onSelected: (value) {
                    if (value == StringConfig.reporting.customRange) {
                      _reportingController.startCircleTypeDateController
                          .clear();
                      _reportingController.endCircleTypeDateController.clear();
                      customRangeDialog(
                        context: context,
                        reportingController: _reportingController,
                        type: StringConfig.reporting.circleTypeSummary,
                      );
                    } else {
                      _reportingController.circleFilterType.value = value;

                      _reportingController.filterCircleType();
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      for (int i = 0;
                          i < (_reportingController.filterOpts.length);
                          i++)
                        PopupMenuItem(
                          value: _reportingController.filterOpts[i],
                          child: Text(
                            _reportingController.filterOpts[i],
                            style: FontTextStyleConfig.fieldTextStyle,
                          ),
                        ),
                    ];
                  },
                ),
                if (_reportingController.circleFilterType.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      _circleController.searchController.clear();
                      _reportingController.circleFilterType.value = '';
                      _circleController.searchedCircle.value =
                          _circleController.circle;
                      _circleController.searchCircleType.value =
                          _circleController.circle;
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: ColorConfig.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

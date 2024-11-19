import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/team_chart/controller/team_chart_controller.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_connection_widget.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_development_widget.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_goals_widget.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_my_q_engagement_widget.dart';

class TeamChartScreen extends StatelessWidget {
  TeamChartScreen({super.key});

  final TeamChartController _teamChartController =
      Get.put(TeamChartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeConfig.size25, vertical: SizeConfig.size30),
              color: ColorConfig.whiteColor,
              child: Text(
                StringConfig.reporting.lastUpdate,
                style: FontTextStyleConfig.dateTextStyle,
              ),
            ),
            SizeConfig.size40.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      teamMyQEngagementWidget(),
                      SizeConfig.size28.height,
                      teamGoalsWidget(),
                    ],
                  ),
                ),
                SizeConfig.size32.width,
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      teamDevelopmentWidget(
                          teamChartController: _teamChartController),
                      SizeConfig.size30.height,
                      teamConnectionWidget(),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: SizeConfig.size32),
            SizeConfig.size40.height
          ],
        ),
      ),
    );
  }
}

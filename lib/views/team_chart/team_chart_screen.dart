import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';
import 'package:mqs_admin_portal_web/views/team_chart/controller/team_chart_controller.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_connection_widget.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_development_widget.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_goals_widget.dart';
import 'package:mqs_admin_portal_web/views/team_chart/widgets/team_my_q_engagement_widget.dart';

class TeamChartScreen extends StatelessWidget {
  TeamChartScreen({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TeamChartController _teamChartController =
      Get.put(TeamChartController());
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          children: [
            homeHeaderWidget(
                homeController: _homeController,
                context: context,
                scaffoldKey: scaffoldKey),
            SizeConfig.size40.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                context.width > SizeConfig.size900
                    ? Row(
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
                      ).paddingSymmetric(horizontal: SizeConfig.size32)
                    : Column(
                        children: [
                          teamMyQEngagementWidget(),
                          SizeConfig.size30.height,
                          teamDevelopmentWidget(
                              teamChartController: _teamChartController),
                          SizeConfig.size30.height,
                          teamGoalsWidget(),
                          SizeConfig.size30.height,
                          teamConnectionWidget(),
                        ],
                      ).paddingSymmetric(horizontal: SizeConfig.size32),
                SizeConfig.size40.height
              ],
            ),
          ],
        ),
      );
  }
}

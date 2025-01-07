import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/database/controller/team_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/team/team_detail_widget.dart';

class TeamDetailScreen extends StatelessWidget {
  TeamDetailScreen({super.key});

  final TeamController _teamController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
          () => teamDetailWidget(teamController: _teamController),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_detail_widget.dart';

class PathwayDetailScreen extends StatelessWidget {
  PathwayDetailScreen({super.key});

  final PathwayController _pathwayController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
          () => pathwayDetailWidget(pathwayController: _pathwayController),
        ),
      ),
    );
  }
}

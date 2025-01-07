import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/database/controller/circle_flagged_post_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/circle_flagged_post/circle_flagged_post_detail_widget.dart';

class CircleFlaggedPostDetailScreen extends StatelessWidget {
  CircleFlaggedPostDetailScreen({super.key});

  final CircleFlaggedPostController _circleFlaggedPostController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
              () => circleFlaggedPostDetailWidget(circleFlaggedPostController: _circleFlaggedPostController),
        ),
      ),
    );
  }
}
